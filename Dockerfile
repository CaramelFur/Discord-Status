FROM rust:1-slim-bookworm AS builder

RUN apt update && apt install -y pkg-config libssl-dev

WORKDIR /usr/src/app
COPY . .

RUN cargo build --release

FROM debian:bookworm-slim

RUN apt update && apt install -y libssl3 ca-certificates && update-ca-certificates

COPY --from=builder /usr/src/app/target/release/discord_status /usr/local/bin/discord_status

CMD ["discord_status"]


