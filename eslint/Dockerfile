FROM node:12.22.0

LABEL "com.github.actions.name"="Run ESLint"
LABEL "com.github.actions.description"="Run ESLint, the pluggable linting utility for JavaScript and JSX."
LABEL "com.github.actions.icon"="circle"
LABEL "com.github.actions.color"="blue"

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
