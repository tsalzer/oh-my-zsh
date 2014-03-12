# Sublime Text 2 Aliases

_sublime_find_path()
{
    local _OS="$1"
    local sublime_linux_paths
    local sublime_linux_names
    local name
    local dir

    case "$OS" in
        Darwin)
            sublime_names=("subl")
            sublime_dirs=(
                "/usr/local/bin"
                "$HOME/Applications/Sublime Text.app/Contents/SharedSupport/bin"
                "$HOME/Applications/Sublime Text 3.app/Contents/SharedSupport/bin"
                "$HOME/Applications/Sublime Text 2.app/Contents/SharedSupport/bin"
                "/Applications/Sublime Text.app/Contents/SharedSupport/bin"
                "/Applications/Sublime Text 3.app/Contents/SharedSupport/bin"
                "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin"
            )
            ;;
        *)
            sublime_names=("subl" "sublime_text" "sublime-text")
            sublime_dirs=(
                "$HOME/bin"
                "/opt/sublime_text"
                "/usr/local/bin"
                "/usr/bin"
            )
            ;;
    esac

    for name in $sublime_names ; do
        for dir in $sublime_dirs ; do
            if [[ -a "$dir/$name" ]]; then
                echo "$dir/$name"
                return 0
                break
            fi
        done
    done
    return 1
}


local _OS >/dev/null 2>&1
_OS=$('uname')

_sublime_path=$(_sublime_find_path "$_OS")
if [[ -n "$_sublime_path" ]] ; then

    case "$_OS" ; in
        Darwin)
            alias subl="'$_sublime_path'"
            alias st=subl
            ;;
        *)
            st_run() { $_sublime_path $@ > /dev/null 2>&1 &| }
            alias st=st_run
            ;;
    esac
    alias stt='st .'

fi

