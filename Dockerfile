
# Use the official Ruby image as the base image
FROM ruby:3.0.0-alpine

# Set the working directory inside the container


# Install system dependencies
RUN apk add --update --virtual --no-cache \
    build-base \
    nodejs \
    sqlite-dev \
    postgresql-dev \
    tzdata \
    git \
    yarn


# Install bundler and gems
COPY Gemfile Gemfile.lock ./
# RUN gem install bundler:2.2.32
ENV BUNDLE_PATH /gems
RUN gem install bundler
RUN bundle install

# Copy the Rails application code into the container
WORKDIR /app
COPY . /app/

# Precompile assets
# RUN bundle exec rails assets:precompile

# Run database migrations
# RUN bundle exec rails db:migrate

ENTRYPOINT ["bin/rails"]

# Start the Rails application
CMD ["server", "-b", "0.0.0.0", "-p", "3000"]
# http://127.0.0.1:3000

# Expose port 3000
EXPOSE 3000