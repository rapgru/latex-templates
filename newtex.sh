#!/bin/bash

# example usage latex-templates/newtex.sh school/text "Kommentar - Essen" essen
# creates essen.tex in current folder with template school/text and title "Kommentar - Essen"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

template="$1"
documentTitle="$2"
filename="$3"

if [[ -z "$template" ]]; then
  echo "You have to supply a template!"
  exit 1
else
  if [[ "$template" = "--list" ]]; then
    echo "available templates are:"
    echo " - formal/brief"
    echo " - formal/lebenslauf"
    echo " - school/protokoll"
    echo " - school/ausarbeitung"
    echo " - school/wochenbericht"
    echo " - school/text"
    exit 0
  else
    templateFile="${DIR}/${template}.tex"
    if [[ -n "$documentTitle" ]]; then
      if [[ -z "$filename" ]]; then
        templateShort="$(basename "$templateFile")"
        cp "${DIR}/${template}.tex" "${PWD}/${templateShort}"
        sed -i 's+<<title>>+'"${documentTitle}"'+g' "${PWD}/${templateShort}"
      else
        cp "${DIR}/${template}.tex" "${PWD}/${filename}.tex"
        sed -i 's+<<title>>+'"${documentTitle}"'+g' "${PWD}/${filename}.tex"
      fi
    else
      templateShort="$(basename "$templateFile")"
      cp "${DIR}/${template}.tex" "${PWD}/${templateShort}"
    fi
  fi
fi