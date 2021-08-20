#!/usr/bin/env ruby

system("aws s3 sync --size-only s3://puyofiles/photos/ ./photos/ --profile puyo")
