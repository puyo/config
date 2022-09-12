#!/usr/bin/env ruby

system("aws s3 sync ./photos/ s3://puyofiles/photos/ --profile puyo")
