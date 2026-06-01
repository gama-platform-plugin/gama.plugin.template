#!/bin/bash
# Initialize this repo from the plugin template.
#
# Usage:
#   bash init.sh <plugin-id> <plugin-label>
#
# Arguments:
#   plugin-id     OSGi bundle ID with exactly 3 dot-separated parts, e.g. gama.plugin.flooding
#   plugin-label  Human-readable name, e.g. "Flooding Simulation"
#
# The feature ID is automatically derived by inserting .feature. before the third part:
#   org.example.myplugin → org.example.feature.myplugin

set -e

PLUGIN_ID="$1"
PLUGIN_LABEL="$2"

MY_PLUGIN_ARCHIVE="MY_PLUGIN.tar.gz"
MY_PLUGIN_FEATURE_ARCHIVE="MY_PLUGIN.feature.tar.gz"
MY_PLUGIN_BASE64="H4sIAAAAAAAAA+1Z/W7bNhDPv9FTHPxXW8SULH8Nru3Gw5IuQ5wEczps2IZCkZmYq0SqJOXEKArsIfaEe5IdSfkrTZalcN0V1RmwpLvf8Y531PFDxB/+8vrs+NXLoxN/5xNRgNRuN8211m4Gq9c57dSaYRAiMwjrO0EtrNUbO9D8VA6tUq50JAF24pmm8eR+3EPyL5TISv4zkZKbNNm4DZPgVqtxX/5rAcrW819vNMMdCDbuyR30lee/+wIzDlMqFRO8V6mRoPKi73UzKf6gsQYUctWrTLTOOr6fRlPKSZRF8YQSIa/8s9Oh3yABKjlk50axBfr6+ppc1y0uxCz7Pw+PR6iYRlXGMeg8pqilWEdZ5rGII219eNAY3Ie4UWPHrFocwedK3wPopmJMk59cJ/tW1vXXeAYUSc0uo1gfjftXURqRLMmvGCeL96PrryCMAhp+EyHkqk/jhGWKVp1K119KHE5Srs0tPlxJkWfYAPpLjJmuP+c4+T1euDZuu4D4InV9fH1apEWC6uhkcDb6/vS860+XnUOgpAkGeErPIj3pE+J/2Lrf9ddAxnd/7jzeuTHR9z73mC1pc7RW/91g2PgU8ED9D8JaeKv+N2qNdln/t0F31H+gPBZjLF69yqvzw+o3dkJ4UZS4JbROGm6qsKPGFpkuvdGUGzFkgnHdq2CRSciCW3Eof8GwZaXQ/9yR+Dpp9f0fHpwPqkcnh5veCDx+/V8P2+X6fyt0Z/6Hg5Ojw4PRORkebsLGQ/W/FTRv1/92WNb/rdAw4uySKl0tVsIdwCnA+zbn44RW58KFLJxLTqKUdmAxdObs0Sy9EAmLnfjOVfRzhTNLQjU219Myp3PVVfv4e5tHCbtkVM7lP9K3OZN0fHBD49xsFA74lEnBU1ydduCHaBqNDqph0ytwVadWOBELSZ9fuIYWE1hgNy57noOMaUb5GKc+RtV9UAuMOBfablXUXBdXxjFVSsgCkTFvkGuRIiquDsU4X0TszpB8zqlv9f1XMv4kZ0Afcf7TxktZ/7dAt/NvBuj/YP5v1YMy/9ugO/PvCtTGhsHj89+sha0y/9ugf8v/pr4MPD7/rWa9VuZ/G/Tf8j+cjd6wJCF/4DLr8TYeOv9vhrfO/8Og3SrP/7dC7qSa3rNW9zyWZkJquL3yxSUvjUWasYRK8hKFgxVZFJvr84/SHYv44xSVGaDrqvbwyfIVGTmx5z975sEzOOBaztwhFVwKCTORS3g5GB6DxRPEGNgRt8w9wBBxrSCOOOSKgp4w5ZBwzfSkY7AAKqNm9wDp7LXFO4TqwK/Isfe/wzsghMD7ov2iAxRSqidirGxrsO8CuAf7V1RrKvFG2RvQAuhNJqwHNDWPxj3jLZxPKJiYnM33IrCMHCw2KIB+UYkWlWkBODXsCENxzSTuyyDSUEQYNEupadn39q3vTzjuYKAHlXlnKk+9fUzXk8ooSjNUcPH4+8+/QNIsiWLqemNDywzCbNWsPwRVs/wCN4oQJ5FSUNQXsAeDGAb39M7zdotYrBp3HGxid828Y6/Zx/5KmoopNQZ3C4unF/bLVjobuJYvGY+S5TaRyJzbrh+NYpFhr8z/U/Rld9f34fz0u9POsjfIlFTnkgPPzfDafe9577+ok8zV+n+Rs2RsNrMZlRoH8qZsPHT+U2t+sP6rN5pl/d8GKXw7Y4olqQdm+vdErrNc2+cLXAJ4+EcYj5N8jCWjB4sjwr3f7FfFFSIfspYflL6od6Kkkkoq6WugfwDsxzAwACgAAA=="
MY_PLUGIN_FEATURE_BASE64="H4sIAAAAAAAAA+2VXW/aMBSGueZXWLnHDtCECYVUvdi6SqVFajttmqbJS0zwlq85Btp/v5PEgZTC0CS0D+08NynH7/lIj/WGsumHz7Prh8urGzoXXC+VYJ0TYwOjkVM++yPHbj8bOn1nYA8gaA+GHbs/dFy3Q5xTD7KPZaG5IqQTPGkRLA7rjp3/o9A9+zdP+pjEJ+lRLth1zw7tv2+PBjv7d0Znww6xT9L9CP/5/r1z2DJZCVXILJ1YfWpbRKRBFso0mlgP9296r6xzv+uZO9ElFTKcWBFPOM3jZSTT5ubQzV2yjDDmX0Q8sV7ENw1h6y51qU2/L3ks51KoRpKrbCVDoXopT8TEuryYXpBZzPU8U4nld0uVF4oiUDLXUIosFTRaaJ0XY8bK4Xq5UdNMRZBRl/34OtVCETMxaVdYCHiFT1Vh1oqbXkGWPykZLfQvdtrmtetvoqZ6LAORFuJIbWZkuz2a7HYHEzP160WZrD0bfLGh9pJs2I9tMSjlNebgd//0zUVOwT7/z7PkZN5fctz/nV3/79su+v/vYI//l3YP5vtVBJrAYVrUhgR+lPCVSCnPebAQlR3NbqfsrDKHWjl+LORGvV6v6XpY6QawZfZ+en0HiWBpMoV/ehoIyCrkuKiC11nAdTXD0WbkkOKxCOtgr9JR+F05pZdkoYjf1S/pV2ceexYrRVxpOeeBvgr9n37bPNZSlokwwDcO0sgXQSzzQvRMjse2R7VQiVTX3u1FKlvmUAEGp2U/jzWR+vzAOHWN3RlAb3boN1/U3t3Nxezu7e29x1bbtwShEvBFkSsx43rhU8peVmceeyYqZ2fN8PBXfTnwE4AgCIIgCIIgCIIgCIIgCIIgCIIgfxk/ANM4mtoAKAAA"

echo "$MY_PLUGIN_BASE64" | base64 -d > $MY_PLUGIN_ARCHIVE
echo "$MY_PLUGIN_FEATURE_BASE64" | base64 -d > $MY_PLUGIN_FEATURE_ARCHIVE

tar -xf $MY_PLUGIN_ARCHIVE
tar -xf $MY_PLUGIN_FEATURE_ARCHIVE

rm $MY_PLUGIN_ARCHIVE
rm $MY_PLUGIN_FEATURE_ARCHIVE


#####################
# Argument Checking #
#####################

if [[ -z "$PLUGIN_ID" || -z "$PLUGIN_LABEL" ]]; then
    echo "Usage: bash init.sh <plugin-id> <plugin-label>"
    echo "  e.g. bash init.sh gama.plugin.flooding \"Flooding Simulation\""
    exit 1
fi

if [[ ! "$PLUGIN_ID" =~ ^[^.]+\.[^.]+\.[^.]+$ ]]; then
    echo "ERROR: plugin-id must have exactly 3 dot-separated parts (e.g. gama.plugin.flooding)"
    exit 1
fi

if [[ ! -d MY_PLUGIN ]]; then
    echo "ERROR: MY_PLUGIN/ not found — has this repo already been initialized?"
    exit 1
fi

####################
# Argument Parsing #
####################

# Derive feature ID: insert .feature. before the third part
PART1="${PLUGIN_ID%%.*}"
REST="${PLUGIN_ID#*.}"
PART2="${REST%%.*}"
PART3="${REST#*.}"
FEATURE_ID="${PART1}.${PART2}.feature.${PART3}"

echo "Plugin ID : $PLUGIN_ID"
echo "Feature ID: $FEATURE_ID"
echo "Label     : $PLUGIN_LABEL"
echo ""

# Derive short name and Java class name from plugin ID
PLUGIN_SHORT="${PLUGIN_ID##*.}"   # gama.plugin.flooding → flooding
CLASS_NAME="$(tr '[:lower:]' '[:upper:]' <<< "${PLUGIN_SHORT:0:1}")${PLUGIN_SHORT:1}Skill"
PACKAGE_PATH="${PLUGIN_ID//.//}"  # gama.plugin.flooding → gama/plugin/flooding

# ── 1. Rename directories ────────────────────────────────────────────────────
echo "Renaming directories..."
mv MY_PLUGIN "$PLUGIN_ID"
mv MY_PLUGIN.feature "$FEATURE_ID"

# ── 2. Plugin bundle (MANIFEST.MF, pom.xml) ─────────────────────────────────
echo "Updating plugin files..."
sed -i \
    -e "s/Bundle-Name: MY_PLUGIN/Bundle-Name: $PLUGIN_LABEL/" \
    -e "s/Bundle-SymbolicName: gama\.plugin\.MY_PLUGIN/Bundle-SymbolicName: $PLUGIN_ID/" \
    -e "s/Automatic-Module-Name: gama\.plugin\.MY_PLUGIN/Automatic-Module-Name: $PLUGIN_ID/" \
    "$PLUGIN_ID/META-INF/MANIFEST.MF"

sed -i "s/gama\.plugin\.MY_PLUGIN/$PLUGIN_ID/g" "$PLUGIN_ID/pom.xml"

# ── 3. Rename Java skill (package dir + class name) ─────────────────────────
echo "Renaming Java skill..."
mkdir -p "$PLUGIN_ID/src/$PACKAGE_PATH"
mv "$PLUGIN_ID/src/gama/plugin/MY_PLUGIN/MySkill.java" \
   "$PLUGIN_ID/src/$PACKAGE_PATH/${CLASS_NAME}.java"
rm -rf "$PLUGIN_ID/src/gama/plugin/MY_PLUGIN"

sed -i \
    -e "s/package gama\.plugin\.MY_PLUGIN/package ${PLUGIN_ID}/" \
    -e "s/my_skill/${PLUGIN_SHORT}_skill/" \
    -e "s/my_action/${PLUGIN_SHORT}_action/" \
    -e "s/MySkill/${CLASS_NAME}/g" \
    "$PLUGIN_ID/src/$PACKAGE_PATH/${CLASS_NAME}.java"

# ── 4. Feature (feature.xml, pom.xml) ───────────────────────────────────────
echo "Updating feature files..."
sed -i \
    -e "s/id=\"gama\.plugin\.feature\.MY_PLUGIN\"/id=\"$FEATURE_ID\"/" \
    -e "s/label=\"MY_PLUGIN\"/label=\"$PLUGIN_LABEL\"/" \
    -e "s/id=\"gama\.plugin\.MY_PLUGIN\"/id=\"$PLUGIN_ID\"/" \
    "$FEATURE_ID/feature.xml"

sed -i "s/gama\.plugin\.feature\.MY_PLUGIN/$FEATURE_ID/g" "$FEATURE_ID/pom.xml"

# ── 5. Parent POM modules ────────────────────────────────────────────────────
echo "Updating parent/pom.xml modules..."
sed -i \
    -e "s|<modules>|<modules>\n    <module>../$PLUGIN_ID</module>|" \
    -e "s|<modules>|<modules>\n    <module>../$FEATURE_ID</module>|" \
    gama.plugin.parent/pom.xml

# ── 6. p2updatesite category.xml ────────────────────────────────────────────
echo "Updating p2updatesite/category.xml..."

FEATURE_XML="\
<feature url=\"features/${FEATURE_ID}_2026.6.0.qualifier.jar\"\n \
           id=\"${FEATURE_ID}\"\n \
           version=\"2026.6.0.qualifier\">\n \
       <category name=\"gama.optional\"/>\n \
   </feature>\n\n    "

sed -i \
    -e "s;<category-def name=\"gama.ui\";${FEATURE_XML}<category-def name=\"gama.ui\";g" \
    gama.plugin.p2updatesite/category.xml

echo ""
echo "Done! Next steps:"
echo "  1. Pull this commit locally"
echo "  2. Open this project in Eclipse (both the plugin and the feature)"
echo "  3. Add your plugin code under $PLUGIN_ID/src/"
echo "  4. Declare OSGi dependencies in $PLUGIN_ID/META-INF/MANIFEST.MF (Require-Bundle)"
echo "  5. (Optional) Adjust the category in p2updatesite/category.xml"
echo "  6. Add your own README.md"
echo "  7. Push to trigger the build"
