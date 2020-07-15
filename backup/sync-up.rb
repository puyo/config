#!/usr/bin/env ruby

system("aws s3 sync ./ s3://puyofiles/ --profile puyo --exclude 'photos/*' --delete")
