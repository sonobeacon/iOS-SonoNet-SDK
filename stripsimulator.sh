#!/bin/sh

echo "\n Removing Unused Architectures \n\n\n"

exec > /tmp/${PROJECT_NAME}_archive.log 2>&1

FRAMEWORK="sonolib"

FRAMEWORK_EXECUTABLE_PATH="${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/$FRAMEWORK.framework/$FRAMEWORK"

EXTRACTED_ARCHS=()

for ARCHICETURES in $ARCHS

do

lipo -extract "$ARCHICETURES" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCHICETURES"

EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCHICETURES")

done

lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"

rm "${EXTRACTED_ARCHS[@]}"
rm "$FRAMEWORK_EXECUTABLE_PATH"
mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"

echo "\n Removing Unused Architectures \n\n\n"
echo "\n\n\n Completed removing unused architectures from the fat framework."
echo "\n\n\n See the log file at /tmp/${PROJECT_NAME}_archive.log for more information. \n\n\n"