#!/bin/zsh

typeset -g POWERLEVEL9K_DOCTL_HIDE_DEFAULT=true

typeset -g POWERLEVEL9K_DOCTL_SHOW_ON_COMMAND='doctl|terraform'

function prompt_doctl() {
    local config_path="${XDG_CONFIG_HOME:-$HOME/.config}/doctl/config.yaml"

    if [[ -f "$config_path" ]]; then
        if [[ -n "$DIGITALOCEAN_CONTEXT" ]]; then
            local doctl_context="$DIGITALOCEAN_CONTEXT"
        else
            local doctl_context="$(cat "$config_path" | grep -E '^context:' | cut -d ':' -f 2- | tr -d '[:space:]')"
        fi

        if $POWERLEVEL9K_DOCTL_HIDE_DEFAULT && [[ "$doctl_context" = "default" ]]; then
            return
        fi

        if [[ -n "$doctl_context" ]]; then
            case "$POWERLEVEL9K_MODE" in
            nerdfont-complete)
                p10k segment -f 39 -i $'\ue7ae' -t "$doctl_context"
                ;;
            *)
                p10k segment -f 39 -t "doctl $doctl_context"
                ;;
            esac
        fi
    fi
}

function instant_prompt_doctl() {
    prompt_doctl
}
