/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1d730eca5a7f1fa8.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_b754744b;

function function_b784c6bd(type) {
  switch (type) {
    case 10:
      self namespace_83eb6304::function_3ecfde67("player_healOS");
      self.health += 150;

      if(self.health < self.health) {
        self.health = self.health;
      } else if(self.health > 150) {
        self.health = 150;
      }

      break;
    case 12:
      break;
    case 46:
      self.doa.var_ccd8393c++;
      self namespace_83eb6304::function_3ecfde67("divine_shield");
      self namespace_83eb6304::function_3ecfde67("player_respawn_red");
      self namespace_83eb6304::function_3ecfde67("player_respawn_yellow");
      break;
  }

  self thread function_6acf8fc6(type);
}

function function_a6ab97f0(type) {
  switch (type) {
    case 10:
      break;
    case 12:
      break;
    case 46:
      self.doa.var_ccd8393c = 0;
      self namespace_83eb6304::turnofffx("divine_shield");
      self namespace_83eb6304::function_3ecfde67("divine_shield_off");
      break;
  }
}

function function_6acf8fc6(type) {
  self endon(#"disconnect");

  switch (type) {
    case 10:
      break;
    case 12:
      break;
    case 46:
      timeout = self namespace_1c2a96f9::function_4808b985(1800);
      self waittilltimeout(timeout, #"hash_226c5964dec34ae7");
      break;
  }

  self thread function_a6ab97f0(type);
}