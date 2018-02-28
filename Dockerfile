from ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -q update && \
 apt-get -q -y install curl python2.7 python-pip && \
 pip install --upgrade awscli && \
 apt-get -q -y clean && \
 rm -rf /var/lib/apt/ /var/cache/apt/ /var/cache/debconf/

#ENV AWS_ACCESS_KEY_ID abc
#ENV AWS_SECRET_ACCESS_KEY def
ENV AWS_ROUTE53_ZONEID xxx
ENV AWS_ROUTE53_HOST example.domain.com
ENV AWS_ROUTE53_TTL 200
ENV UPDATE_INTERVAL 1000

# You can use public web services that provide plain text IP address
# Example: https://wtfismyip.com/text
# For Amazon EC2 (and its containers) it's recommended using instance meta-data
ENV IP_PROVIDER=http://169.254.169.254/latest/meta-data/local-ipv4

ADD update-route53.sh /update-route53.sh
RUN chmod +x /update-route53.sh

ENTRYPOINT "/update-route53.sh"
