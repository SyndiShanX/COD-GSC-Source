/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7aeb0ef28c222444.gsc
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
#using script_7857e1ad7dfdbc95;
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
#namespace namespace_545df111;

function function_90cdf7ba(type, origin) {
  count = 1;
  var_e254c3ed = undefined;

  switch (type) {
    case 34:
      count = randomintrange(5, 10);
      name = "skeleton_spear";
      var_2d8ae5ef = "player_trail_" + self.doa.color;
      killnote = array("doa_exit_taken", "arena_completed", "game_over");
      var_4d5cf4b2 = level;
      namespace_e32bb68::function_3a59ec34("guardian_type_skeleton");
      break;
    default:
      assert(0, "<dev string:x38>");
      break;
  }

  spawndef = doa_enemy::function_d7c5adee(name);

  if(isDefined(spawndef)) {
    while(count) {
      count--;
      var_1c446dd6 = namespace_ec06fe4a::function_38de0ce8();

      if(var_1c446dd6 >= 44) {
        continue;
      }

      ai = doa_enemy::function_db55a448(spawndef, origin + (randomintrange(-40, 40), randomintrange(-40, 40), 0));

      if(isDefined(ai)) {
        ai.owner = self;

        if(isDefined(var_2d8ae5ef)) {
          ai namespace_83eb6304::function_3ecfde67(var_2d8ae5ef);
        }

        if(isDefined(var_e254c3ed)) {
          ai thread[[var_e254c3ed]]();
        }

        if(isDefined(killnote) && isDefined(var_4d5cf4b2)) {
          if(isarray(killnote)) {
            foreach(note in killnote) {
              ai thread namespace_ec06fe4a::function_d55f042c(var_4d5cf4b2, note);
            }

            continue;
          }

          ai thread namespace_ec06fe4a::function_d55f042c(var_4d5cf4b2, killnote);
        }
      }
    }
  }
}