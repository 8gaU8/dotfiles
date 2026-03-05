#* === Environment Variables ===

# pip: Avoid pip installation without venv
export PIP_REQUIRE_VIRTUALENV=1

# man: use bat as manpager
export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | $(which bat) -p -lman'"
