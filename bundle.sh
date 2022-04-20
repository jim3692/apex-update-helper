#!/bin/bash

set -e

if [ ! -d '.git' ]; then
  echo 'Not running in the project root' > /dev/stderr
  exit 1
fi

PROJECT_ROOT=$PWD
CLASSES_PATH='.build/main/default/classes'
CLASS_REGEX="(\d|\w|_)+"

[ -d .build ] && rm -rf .build
cp -r src .build

cd $CLASSES_PATH

function scanExternals () {
  find -path './externals/*' -name '*.cls'
}

function scanClasses () {
  find -not -path './externals/*' -name '*.cls'
}

function nameOfClass () {
  while read -r line; do
    echo $line | sed -E "s/^.*\/($CLASS_REGEX).cls$/\1/"
    # echo $line | egrep -o "$CLASS_REGEX.cls$" | egrep -o "^$CLASS_REGEX"
  done
}

function classInjectExternalBody () {
  outerClassPath=$1
  echo "outerClassPath: $outerClassPath"

  # Check if class has 'extends' tokens
  (grep 'extends' $outerClassPath > /dev/null) || return 0

  # Loop over extended classes
  extendedClasses=$(egrep -o "$CLASS_REGEX\s+extends\s+$CLASS_REGEX" $outerClassPath)
  echo "$extendedClasses" | while IFS= read -r extendedClass; do
    extendedClassName=$(echo $extendedClass | egrep -o "^$CLASS_REGEX")
    baseClassName=$(echo $extendedClass | egrep -o "$CLASS_REGEX$")

    echo "== $extendedClassName Started =="

    echo "extendedClass: $extendedClass"
    echo "extendedClassName: $extendedClassName"
    echo "baseClassName: $baseClassName"

    # Skip if base class is not in the 'externals' directory
    (echo "$externals" | grep "$baseClassName" > /dev/null) || continue

    baseClassPath=$(echo "$externals" | grep "$baseClassName.cls")
    echo "baseClassPath: $baseClassPath"

    # Replace baseClassName with extendedClassName
    sed -i -E "s|$baseClassName|$extendedClassName|g" $baseClassPath

    # Remove abstract keyword
    sed -i -E "s/abstract\s+//g" $baseClassPath

    # Fix indentation
    sed -i "s/^/  /g" $baseClassPath

    # Fix Constructors
    sed -i "s|public void externalInit|public $extendedClassName|g" $baseClassPath

    # Replace foreign externalInit calls
    foreignExternalInitCalls=$(grep -n "\.externalInit" $baseClassPath || true)
    if [ ! "$foreignExternalInitCalls" == "" ]; then
      # Update constructor calls
      echo "$foreignExternalInitCalls" | while read -r externalInitCall ; do
        lineNumber=$(echo "$externalInitCall" | gawk '{print $1}' FS=":")
        previousLineNumber=$(expr $lineNumber - 1)
        parameters=$(echo "$externalInitCall" | egrep -o "\\(.*\\);")
        sed -i "${previousLineNumber}s|();|$parameters|" $baseClassPath
      done

      # Remove externalInit calls
      echo "$foreignExternalInitCalls" | while read -r externalInitCall ; do
        line=$(echo "$externalInitCall" | gawk '{print $2}' FS=":")
        sed -i "/$line/d" $baseClassPath
      done
    fi

    # Replace internal externalInit calls
    internalExternalInitCalls=$(grep -n "externalInit" $baseClassPath || true)
    if [ ! "$internalExternalInitCalls" == "" ]; then
      # Inject constructor body
      echo "$internalExternalInitCalls" | while read -r externalInitCall ; do
        callLine=$(echo "$externalInitCall" | gawk '{print $2}' FS=":")

        # Calculate constructor line numbers
        constructorLineNumber=$(grep -n "public $extendedClassName" $baseClassPath | gawk '{print $1}' FS=":" | head -n 1)
        constructorBodyFirstLineNumber=$(expr $constructorLineNumber + 1)
        constructorClosingBrace=$(tail -n "+$constructorBodyFirstLineNumber" $baseClassPath | grep -n "    }" | head -n 1 | gawk '{print $1}' FS=":")
        constructorClosingBrace=$(expr $constructorClosingBrace + $constructorBodyFirstLineNumber - 1)
        constructorBodyLastLineNumber=$(expr $constructorClosingBrace - 1)
        constructorBodyLength=$(expr $constructorBodyLastLineNumber - $constructorBodyFirstLineNumber + 1)

        # Replace
        constructorBodyLines=$(tail -n "+$constructorBodyFirstLineNumber" $baseClassPath | head -n $constructorBodyLength)
        echo "$constructorBodyLines" | while read -r line ; do
          sed -i "s/$callLine/      $line\n$callLine/" $baseClassPath
        done
        sed -i "s/$callLine//" $baseClassPath
      done

      # Remove externalInit calls
      echo "$foreignExternalInitCalls" | while read -r externalInitCall ; do
        line=$(echo "$externalInitCall" | gawk '{print $2}' FS=":")
        sed -i "/$line/d" $baseClassPath
      done
    fi

    # Inject base class to outer class
    extendedClassLine=$(cat $outerClassPath | grep "$extendedClass")
    echo "extendedClassLine: $extendedClassLine"
    sed -i "s|&|\\\\&|g" $baseClassPath
    sed -i "s|$extendedClassLine|$(cat $baseClassPath | tr '\n' '\t')|g" $outerClassPath
    tr '\t' '\n' < $outerClassPath > "$outerClassPath.new"
    rm $outerClassPath
    mv "$outerClassPath.new" $outerClassPath

    # Fix bundler-make-final
    sed -i "s|/\* bundler-make-final \*/ private|private final|g" $outerClassPath
    sed -i "s|/\* bundler-make-final \*/ protected|protected final|g" $outerClassPath
    sed -i "s|/\* bundler-make-final \*/ public|public final|g" $outerClassPath
    sed -i "s|/\* bundler-make-final \*/ global|global final|g" $outerClassPath

    # Fix bundler-make-private
    sed -i "s|/\* bundler-make-private \*/ public|private|g" $outerClassPath

    # Trim empty lines
    sed -i "s/^\s+$//g" $outerClassPath

    # Delete Class
    rm $baseClassPath

    echo "== $extendedClassName Completed =="
  done

  # cat $class | sed -E "s/^.*extends $CLASS_REGEX.*$//g"
}

function classRemoveExtends () {
  while read class; do
    cat $class | sed -E "s/extends $CLASS_REGEX //g"
  done
}

externals=$(scanExternals)
externalsNames=$(echo "$externals" | nameOfClass)
classes=$(scanClasses)
classesNames=$(echo "$classes" | nameOfClass)

echo "$classes" | while IFS= read -r line; do classInjectExternalBody $line; done
