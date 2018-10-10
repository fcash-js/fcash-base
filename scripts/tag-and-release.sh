#!/bin/bash
set -e

######### Adjust these variables as needed ################

insightApiDir="${HOME}/source/insight-api"
insightUIDir="${HOME}/source/insight-ui"
fcoreDir="${HOME}/source/fcore"
fcoreNodeDir="${HOME}/source/fcash-node"

###########################################################

# given a string tag, make signed commits, push to relevant repos, create signed tags and publish to npm

bump_version () {
  sed -i '' -e "s/\"version\"\: .*$/\"version\"\: \"${shortTag}\",/g" package.json
}

set_deps () {
  sed -i '' -e "s/\"fcash-node\"\: .*$/\"fcash-node\"\: \"${shortTag}\",/g" package.json
  sed -i '' -e "s/\"insight-api\"\: .*$/\"insight-api\"\: \"${shortTag}\",/g" package.json
  sed -i '' -e "s/\"insight-ui\"\: .*$/\"insight-ui\"\: \"fcash\/insight\#${tag}\"/g" package.json
}

tag="${1}"
shortTag=`echo "${tag}" | cut -c 2-`

if [ -z "${tag}" ]; then
  echo ""
  echo "No tag given, exiting."
  exit 1
fi


#############################################
# fcash-node
#############################################
function fcoreNode() {
  echo ""
  echo "Starting with fcash-node..."
  sleep 2
  pushd "${fcoreNodeDir}"

  sudo rm -fr node_modules
  bump_version
  npm install

  git add .
  git diff --staged
  echo ""
  echo -n 'Resume?: (Y/n): '

  read ans

  if [ "${ans}" == 'n' ]; then
    echo "Exiting as requested."
    exit 0
  fi

  echo ""
  echo "Committing changes for fcash-node..."
  sleep 2
  git commit -S

  echo ""
  echo "Pushing changes to Github..."
  git push origin master && git push upstream master

  echo ""
  echo "Signing a tag"
  git tag -s "${tag}" -m"${tag}"


  echo ""
  echo "Pushing the tag to upstream..."
  git push upstream "${tag}"

  echo ""
  echo "Publishing to npm..."
  npm publish --tag beta

  popd
}

#############################################
# insight-api
#############################################
function insightApi() {
  echo ""
  echo "Releasing insight-api..."
  sleep 2
  pushd "${insightApiDir}"

  sudo rm -fr node_modules
  bump_version
  npm install

  git add .
  git diff --staged
  echo ""
  echo -n 'Resume?: (Y/n): '

  read ans

  if [ "${ans}" == 'n' ]; then
    echo "Exiting as requested."
    exit 0
  fi

  echo ""
  echo "Committing changes for insight-api..."
  sleep 2
  git commit -S

  echo ""
  echo "Pushing changes to Github..."
  git push origin master && git push upstream master

  echo ""
  echo "Signing a tag"
  git tag -s "${tag}" -m"${tag}"


  echo ""
  echo "Pushing the tag to upstream..."
  git push upstream "${tag}"

  echo ""
  echo "Publishing to npm..."
  npm publish --tag beta

  popd
}

#############################################
# insight-ui
#############################################
function insightUi() {
  echo ""
  echo "Releasing insight-ui..."
  sleep 2
  pushd "${insightUIDir}"

  sudo rm -fr node_modules
  bump_version
  npm install

  git add .
  git diff --staged
  echo ""
  echo -n 'Resume?: (Y/n): '

  read ans

  if [ "${ans}" == 'n' ]; then
    echo "Exiting as requested."
    exit 0
  fi

  echo ""
  echo "Committing changes for insight-ui..."
  sleep 2
  git commit -S

  echo ""
  echo "Pushing changes to Github..."
  git push origin master && git push upstream master

  echo ""
  echo "Signing a tag"
  git tag -s "${tag}" -m"${tag}"


  echo ""
  echo "Pushing the tag to upstream..."
  git push upstream "${tag}"

  echo ""
  echo "Publishing to npm..."
  npm publish --tag beta

  popd
}

#############################################
# fcore
#############################################
function fcore() {
  echo ""
  echo "Releasing fcore..."
  sleep 2
  pushd "${fcoreDir}"

  sudo rm -fr node_modules
  bump_version
  set_deps

  npm install

  git add .
  git diff --staged
  echo ""
  echo -n 'Resume?: (Y/n): '

  read ans

  if [ "${ans}" == 'n' ]; then
    echo "Exiting as requested."
    exit 0
  fi

  echo ""
  echo "Committing changes for fcore..."
  sleep 2
  git commit -S

  echo ""
  echo "Pushing changes to Github..."
  git push origin master && git push upstream master

  echo ""
  echo "Signing a tag"
  git tag -s "${tag}" -m"${tag}"


  echo ""
  echo "Pushing the tag to upstream..."
  git push upstream "${tag}"

  echo ""
  echo "Publishing to npm..."
  npm publish --tag beta

  popd

  echo "Completed releasing tag: ${tag}"
}

echo ""
echo "Tagging with ${tag}..."

echo "Assuming projects at ${HOME}/source..."

releases="${2}"
if [ -z "${releases}" ]; then
  fcoreNode
  insightApi
  insightUi
  fcore
else
  eval "${releases}"
fi

