FROM alpine:latest AS build

ARG VERSION=1.3

RUN apk add --update zip bash
RUN wget https://justine.lol/redbean/redbean-${VERSION}.com -O redbean.com
RUN chmod +x redbean.com

# This will normalize the binary to ELF
RUN zip -d redbean.com .ape
RUN ls -la redbean.com
RUN zip -sf redbean.com
RUN bash /redbean.com -h


FROM scratch

COPY --from=build /redbean.com /
CMD ["/redbean.com", "-vv", "-p", "80"]
