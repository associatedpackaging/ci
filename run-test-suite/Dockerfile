FROM ruby:2.6

LABEL "com.github.actions.name"="Run Automated Test Suite"
LABEL "com.github.actions.description"="Runs test suite."
LABEL "com.github.actions.icon"="circle"
LABEL "com.github.actions.color"="red"

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
