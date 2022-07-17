FROM python:3.10-alpine
RUN pip install ansible==5.10.0
RUN apk add openssh bash git
COPY entry_point.sh /
COPY launch.sh /
ENTRYPOINT ["/entry_point.sh"]
