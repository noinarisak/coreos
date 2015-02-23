export PATH=${PATH}:/home/core/tools/bin

function sudo() {
   local ARGS
   declare -a ARGS=()
   while (( $# )); do
      if [[ "${1:0:1}" == "-" ]]; then
         # the argument is a dash-arg; '-s' for example
         ARGS[${#ARGS[@]}]="$1"
         if [[ "$1" =~ ^-[pugD]$ ]]; then
            # these are the arguments that take a parameter, so skip the next
            ARGS[${#ARGS[@]}]="$2"
            shift
         fi
         shift
      elif [[ "$1" == *"="* ]]; then
         # the argument is a env var to set, not a command
         ARGS[${#ARGS[@]}]="$1"
         shift
      else
         # finally, a command
         CMD="$(which --skip-alias --skip-functions "$1")"
         [[ -z "$CMD" ]] && ARGS[${#ARGS[@]}]="$1" || ARGS[${#ARGS[@]}]="$CMD"
         shift
         break
      fi
   done
   command sudo "${ARGS[@]}" "$@"
}
