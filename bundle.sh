#!/bin/bash

set -e

if [ ! -d '.git' ]; then
  echo 'Not running in the project root' > /dev/stderr
  exit 1
fi

PROJECT_ROOT=$PWD
CLASSES_PATH='.build/main/default/classes'
CLASS_REGEX="[A-Z](\d|\w|_)+"

[ -d .build ] && rm -rf .build
cp -r src .build

cd $CLASSES_PATH

function scanExternals () {
  find -path './externals/*' -name '*.cls'
}

function scanClasses () {
  find -not -path './externals/*' -name '*.cls'
}

function scanTestExternals () {
  find -path './tests/externals/*' -name '*.cls'
}

function scanTestClasses () {
  find -maxdepth 2 -path './tests/*' -name '*.cls'
}

function nameOfClass () {
  while read -r line; do
    echo $line | sed -E "s/^.*\/($CLASS_REGEX).cls$/\1/"
  done
}

function fixBaseClass () {
  export baseClassName=$1
  export extendedClassName=$(echo $baseClassName | gawk '{print $2}' FS="_")
  export baseClassPath=$(echo "$externals" | grep "$baseClassName.cls")

  # Replace baseClassName with extendedClassName
  sed -i -E "s|$baseClassName|$extendedClassName|g" $baseClassPath

  # Remove abstract keyword
  sed -i -E "s/abstract\s+//g" $baseClassPath

  # Fix indentation
  sed -i "s/^/  /g" $baseClassPath

  # Fix Constructors
  sed -i "s|public void externalInit|public $extendedClassName|g" $baseClassPath

  foreignExternalInitCalls $baseClassPath
  externalInitCalls $baseClassPath
}

function foreignExternalInitCalls () {
  local classPath=$1

  # Replace foreign externalInit calls
  foreignExternalInitCalls=$(grep -n "\.externalInit" $classPath || true)
  if [ ! "$foreignExternalInitCalls" == "" ]; then
    # Update constructor calls
    echo "$foreignExternalInitCalls" | while read -r externalInitCall ; do
      lineNumber=$(echo "$externalInitCall" | gawk '{print $1}' FS=":")
      previousLineNumber=$(expr $lineNumber - 1)
      parameters=$(echo "$externalInitCall" | egrep -o "\\(.*\\);")
      sed -i "${previousLineNumber}s|();|$parameters|" $classPath
    done

    # Remove externalInit calls
    echo "$foreignExternalInitCalls" | while read -r externalInitCall ; do
      line=$(echo "$externalInitCall" | gawk '{print $2}' FS=":")
      sed -i "/$line/d" $classPath
    done
  fi
}

function externalInitCalls () {
  local classPath=$1

  # Replace internal externalInit calls
  internalExternalInitCalls=$(grep -n "externalInit" $classPath || true)
  if [ ! "$internalExternalInitCalls" == "" ]; then
    # Inject constructor body
    echo "$internalExternalInitCalls" | while read -r externalInitCall ; do
      callLine=$(echo "$externalInitCall" | gawk '{print $2}' FS=":")

      # Calculate constructor line numbers
      constructorLineNumber=$(grep -n "public $extendedClassName" $classPath | gawk '{print $1}' FS=":" | head -n 1)
      constructorBodyFirstLineNumber=$(expr $constructorLineNumber + 1)
      constructorClosingBrace=$(tail -n "+$constructorBodyFirstLineNumber" $classPath | grep -n "    }" | head -n 1 | gawk '{print $1}' FS=":")
      constructorClosingBrace=$(expr $constructorClosingBrace + $constructorBodyFirstLineNumber - 1)
      constructorBodyLastLineNumber=$(expr $constructorClosingBrace - 1)
      constructorBodyLength=$(expr $constructorBodyLastLineNumber - $constructorBodyFirstLineNumber + 1)

      # Replace
      constructorBodyLines=$(tail -n "+$constructorBodyFirstLineNumber" $classPath | head -n $constructorBodyLength)
      echo "$constructorBodyLines" | while read -r line ; do
        sed -i "s/$callLine/      $line\n$callLine/" $classPath
      done
      sed -i "s/$callLine//" $classPath
    done

    # Remove externalInit calls
    echo "$foreignExternalInitCalls" | while read -r externalInitCall ; do
      line=$(echo "$externalInitCall" | gawk '{print $2}' FS=":")
      sed -i "/$line/d" $classPath
    done
  fi
}

function escapeFile () {
  cat $1 | jq -Rsc | sed "s|&|\\\\&|g" | sed 's/^\"//' | sed 's/\"$//'
}

function escapeLine () {
  echo $1 | jq -Rsc | sed 's/^\"//' | sed 's/\"$//'
}

function fixClass () {
  outerClassPath=$1

  # Check if class has 'extends' tokens
  (grep 'extends' $outerClassPath > /dev/null) || return 0

  # Loop over extended classes
  extendedClasses=$(egrep -o "$CLASS_REGEX\s+extends\s+$CLASS_REGEX" $outerClassPath)
  echo "$extendedClasses" | while IFS= read -r extendedClass; do
    extendedClassName=$(echo $extendedClass | egrep -o "^$CLASS_REGEX")
    baseClassName=$(echo $extendedClass | egrep -o "$CLASS_REGEX$")

    # Skip if base class is not in the 'externals' directory
    (echo "$externals" | grep "$baseClassName" > /dev/null) || continue

    baseClassPath=$(echo "$externals" | grep "$baseClassName.cls")

    # Inject base class to outer class
    extendedClassLine=$(cat $outerClassPath | grep "$extendedClass")
    sed -i "s|$extendedClassLine|$(escapeFile $baseClassPath)|g" $outerClassPath
  done
}

function classBundlerMake () {
  outerClassPath=$1

  # Fix bundler-make-final
  sed -i "s|/\* bundler-make-final \*/ private|private final|g" $outerClassPath
  sed -i "s|/\* bundler-make-final \*/ protected|protected final|g" $outerClassPath
  sed -i "s|/\* bundler-make-final \*/ public|public final|g" $outerClassPath
  sed -i "s|/\* bundler-make-final \*/ global|global final|g" $outerClassPath

  # Fix bundler-make-private
  sed -i "s|/\* bundler-make-private \*/ public|private|g" $outerClassPath
}

function prepareExternalTestClassForInjection () {
  local classPath=$1
  local className=$(echo $classPath | nameOfClass)
  sed -i -E "/^@IsTest$/d" $classPath
  sed -i -E "/^class $className \{$/d" $classPath
  sed -i -E "/^\}$/d" $classPath
  sed -i -E "s/static void ((\d|\w|_)+)/static void ${className}_\1/g" $classPath
}

function classBundlerInject () {
  local outerClassPath=$1
  local injectables=$2

  # Check if class has 'bundler-inject' comment
  (grep 'bundler-inject' $outerClassPath > /dev/null) || return 0

  local bundlerInjectRegex="/\* bundler-inject $CLASS_REGEX \*/"

  local targetClasses=$(egrep -o "$bundlerInjectRegex" $outerClassPath)
  echo "$targetClasses" | while IFS= read -r targetClass; do

    local targetClassName=$(echo "$targetClass" | egrep -o "$CLASS_REGEX")

    # Error if base class is not in the $injectables directory
    (echo "$injectables" | grep "$baseClassName" > /dev/null) \
      || (echo "Class '$targetClassName' not found" > /dev/stderr ; exit 1)

    local targetClassPath=$(echo "$injectables" | grep "$targetClassName.cls")

    # Inject base class to outer class
    sed -i -E "s/^  \/\* bundler-inject $targetClassName \*\/$/$(escapeFile $targetClassPath)/" $outerClassPath
  done
}

function trimEmptyLines () {
  outerClassPath=$1

  # Trim empty lines
  sed -i "s/ *$//g" $outerClassPath
}

function beautify () {
  local classPath=$1

  sed -i '/^$/d' $classPath
  sed -i -E "s/^  \}$/  }\n/g" $classPath
  sed -i -E "s/^  [^ ].*;$/\0\n/g" $classPath
}

externals=$(scanExternals)
externalsNames=$(echo "$externals" | nameOfClass)
classes=$(scanClasses)
classesNames=$(echo "$classes" | nameOfClass)
testExternals=$(scanTestExternals)
testExternalsNames=$(echo "$testExternals" | nameOfClass)
testClasses=$(scanTestClasses)
testClassesNames=$(echo "$testClasses" | nameOfClass)

echo "$externalsNames" | while IFS= read -r line; do fixBaseClass $line; done
echo "$classes" | while IFS= read -r line; do foreignExternalInitCalls $line; done
echo "$classes" | while IFS= read -r line; do fixClass $line; done
echo "$classes" | while IFS= read -r line; do classBundlerMake $line; done
echo "$classes" | while IFS= read -r line; do trimEmptyLines $line; done
echo "$externals" | while IFS= read -r line; do rm $line; done
echo "$testExternals" | while IFS= read -r line; do prepareExternalTestClassForInjection $line; done
echo "$testClasses" | while IFS= read -r line; do classBundlerInject $line "$testExternals"; done
echo "$testExternals" | while IFS= read -r line; do rm $line; done

echo "$classes" | while IFS= read -r line; do [ -f $line ] && beautify $line ; done

find './' -empty -type d -delete
