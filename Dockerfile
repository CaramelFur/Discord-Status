# Build rust project
FROM rust:alpine AS chef
WORKDIR /app
RUN apk add --no-cache musl-dev
RUN cargo install cargo-chef

FROM chef AS planner
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

FROM chef AS builder
COPY --from=planner /app/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json
COPY . .
RUN cargo build --release

# Build final image
FROM alpine:latest AS runtime
WORKDIR /app
COPY --from=builder /app/target/release/discord_status ./app
ENTRYPOINT [ "./app" ]


