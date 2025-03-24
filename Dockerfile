FROM ruby:3.0.0

# Install system dependencies
RUN apt-get update -yqq
RUN apt-get install -yqq --no-install-recommends nodejs

# Copy app files
COPY . /usr/src/app
# Set environment variables
ARG SECRET_KEY_BASE

WORKDIR /usr/src/app
ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=${SECRET_KEY_BASE}

# Install Ruby dependencies
RUN gem install bundler:2.2.3
RUN bundle install

RUN rake db:migrate
# Precompile assets (optional, depending on workflow)
RUN rails assets:precompile

# Start Rails server
CMD ["rails", "server"]
