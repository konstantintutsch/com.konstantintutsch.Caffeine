[private]
default:
    just --list --justfile {{ justfile() }}

flathub:
    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak run --command=flatpak-builder-lint org.flatpak.Builder manifest \
        com.konstantintutsch.Caffeine.yaml
    flatpak run org.flatpak.Builder \
        --force-clean --sandbox --ccache \
        --user --install --install-deps-from=flathub \
        --mirror-screenshots-url=https://dl.flathub.org/media/ --repo=repo builddir \
        com.konstantintutsch.Caffeine.yaml
    flatpak run --command=flatpak-builder-lint org.flatpak.Builder repo repo
