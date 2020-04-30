FROM elixir:1.10.1

ENV DEBIAN_FRONTEND=noninteractive

# Update package control
RUN apt-get -y update

# Install Hex
RUN mix local.hex --force

# Install Rebar
RUN mix local.rebar --force

WORKDIR /app
