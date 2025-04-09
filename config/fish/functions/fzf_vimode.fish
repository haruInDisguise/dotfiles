function fzf_vimode
    _fzf_vimode_impl (string encode --style=var $FZF_WRAPPER_OPTIONS)
end

# 1.  Look into the 'reload()' action + 'start' event
#   - Actions can be bound to events, just like keys: event:action...
function _fzf_vimode_impl -a fzf_cmd fzf_args
    fzf \
        --no-input \
        --bind 'j:down,k:up,/:show-input+unbind(j,k,/,l,g,G,J,K,q)+pos(1)' \
        --bind 'enter,esc,ctrl-c:transform:
            if [[ $FZF_INPUT_STATE = enabled ]]; then
                echo "rebind(j,k,/,l,g,G,J,K,q)+hide-input"
            elif [[ $FZF_KEY = enter ]]; then
                echo "execute-silent(echo {n} > /tmp/fzf-pos)+accept"
            else
                echo abort
            fi
        ' (string decode --style=var $fzf_args)
end
