require('pry-byebug')
require_relative('model/bounty')

bounty1 = Bounty.new({'name' => 'JarJar', 'bounty_value' => '1000', 'danger_level' => 'medium', 'favourite_weapon' => 'space rifle'})
bounty2 = Bounty.new({'name' => 'Jabba The Hutt', 'bounty_value' => '2500', 'danger_level' => 'high', 'favourite_weapon' => 'cosmic granade'})


bounty1.save
bounty2.save

all_bounty = Bounty.all
p all_bounty

bounty1.delete
