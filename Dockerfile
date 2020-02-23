FROM rust as builder
RUN rustup default nightly
RUN mkdir -p /app
COPY  . .
RUN cargo build --release
COPY . /app
FROM nginx:1.16.1-alpine
COPY --from=builder ./target/release/rust_web_app_2 /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx","-g","daemon off;"]

