FROM alpine:latest AS build

ARG DOWNLOAD_FILENAME=redbean-original-tinylinux-1.4.com

RUN apk add --update zip bash
RUN wget https://justine.lol/redbean/${DOWNLOAD_FILENAME} -O redbean.com
RUN chmod +x redbean.com

FROM scratch

COPY --from=build /redbean.com /
CMD ["/redbean.com", "-vv", "-p", "80"]
