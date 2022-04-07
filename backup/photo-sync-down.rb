#!/usr/bin/env ruby

system("aws s3 sync s3://puyofiles/photos/ ./photos/ --profile puyo  --exclude '*' --include 'photos/*'")
