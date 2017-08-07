#!/usr/bin/env ruby

require 'json'

# adapted from https://stackoverflow.com/a/8707236
def upcase_first(string)
  k = string.dup
  k[0] = k[0].upcase
  k
end

def convert_hash_keys(value)
  case value
  when Array
    value.map { |v| convert_hash_keys(v) }
  when Hash
    Hash[value.map { |k, v| [upcase_first(k), convert_hash_keys(v)] }]
  else
    value
   end
end

file = File.read('/tmp/ecs.json')
json = JSON.parse(file)

puts JSON.pretty_generate(convert_hash_keys(json))
