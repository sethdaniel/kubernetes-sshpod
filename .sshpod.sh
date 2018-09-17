#!/bin/bash

#=== FUNCTION ================================================================
# NAME: sshpod
# DESCRIPTION: SSH into a Kubernetes pod lickety split!
#===============================================================================
function sshpod() {

  export ALL_PODS_LIST="$(kubectl get pods)"
  declare -a ALL_PODS
  export POD_NUM=-1

  while read -r line; do

    # Fear the incrementor!!!
    ((POD_NUM=POD_NUM+1))
    export LAST_POD_NUM=$POD_NUM

    # Skip column headers line.
    if [ "$POD_NUM" == 0 ]
    then
      continue
    fi

    # Get the pod name as it's own string variable
    export CURRENT_POD_NAME=${line%% *}

    # Add pod name to array at the appropriate index.
    ALL_PODS[$POD_NUM]=$CURRENT_POD_NAME

    # echo ${ALL_PODS[@]}

  done <<< "$ALL_PODS_LIST"

  # List pod selection number and then pod name.
  listPodsByPodNum "$LAST_POD_NUM" "${ALL_PODS[@]}"

  # Get user pod selection by number.
  echo "Please enter the number of the pod that you'd like to diddle:"
  read SELECTED_POD_NUMBER

  # Validate that user has entered a pod number that was actually listed.
  # If user input is not valid reject with message
  while [[ $((SELECTED_POD_NUMBER)) != $SELECTED_POD_NUMBER ]] || [[ "$SELECTED_POD_NUMBER" -gt "$LAST_POD_NUM" ]] || [[ $SELECTED_POD_NUMBER < 1 ]]
  do
    echo "This isn't rocket science.  Your input needs to be the number next to the pod that you're trying to diddle.  Maybe try entering some non-gibberish this time:"
    read SELECTED_POD_NUMBER
    # read -s -p "This isn't rocket science.  Your input needs to be the number next to the pod that you're trying to diddle.  Maybe try entering some non-gibberish this time: " SELECTED_POD_NUMBER
  done

  # Get pod name as a string.
  export SELECTED_POD_NAME=${ALL_PODS[$SELECTED_POD_NUMBER]}
  echo "$SELECTED_POD_NAME"

  # Run the ssh command for that pod.
  kubectl exec -it "$SELECTED_POD_NAME" -- /bin/bash
}


#=== FUNCTION ================================================================
# NAME: listPodsByPodNum
# DESCRIPTION: Lists the available pods with a pod number that can be used to select a pod.
#===============================================================================
function listPodsByPodNum() {

  local LAST_POD_NUM="$1"
  local ALL_PODS_NUMS=("$@")

  export CURRENT_POD_NUM=1

  while [ $CURRENT_POD_NUM -le $LAST_POD_NUM ]
  do
    # echo "sethtest04"
    echo "$CURRENT_POD_NUM --> ${ALL_PODS_NUMS[$CURRENT_POD_NUM]}"
    ((CURRENT_POD_NUM=CURRENT_POD_NUM+1))
  done

}
