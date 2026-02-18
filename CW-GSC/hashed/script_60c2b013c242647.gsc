/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_60c2b013c242647.gsc
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
#namespace namespace_b0e844dd;

function function_922745a1(player) {
  self endon(#"death");
  self endon(#"hash_1e744934a54fe4bc");
  player endon(#"disconnect");
  weapon = getweapon("zombietron_sprinkler_grenade");
  top = self.origin + (0, 0, 32);

  while(true) {
    self rotateto(self.angles + (0, 15, 0), 0.2);
    wait 0.2;
    forward = anglesToForward(self.angles + (0, 0, 500));
    velocity = forward * (getdvarint(#"hash_6e23b1c0ac2fdd38", 150) + randomintrange(-50, 50));
    boost = sin(self.angles[1]);

    if(boost < 0) {
      boost *= -1;
    }

    up = mapfloat(0, 1, 300, 900, boost);
    velocity += (0, 0, up);
    player magicgrenadetype(weapon, top, velocity);
  }
}

function function_d275f769(player, origin) {
  var_497e327b = origin + (0, 0, 800);
  sprinkler = namespace_ec06fe4a::spawnmodel(var_497e327b, "zombietron_sprinkler");

  if(!isDefined(sprinkler)) {
    return;
  }

  sprinkler.targetname = "sprinkler";
  sprinkler notsolid();
  target = player.origin;

  if(isDefined(player.doa.vehicle)) {
    target = namespace_ec06fe4a::function_65ee50ba(player.origin);
  }

  mark = target + (0, 0, 12);
  sprinkler moveto(mark, 0.5);
  sprinkler waittilltimeout(1, #"movedone");
  sprinkler namespace_e32bb68::function_3a59ec34("evt_doa_pickup_sprinkler_land");
  sprinkler namespace_83eb6304::function_3ecfde67("sprinkler_land");
  physicsexplosionsphere(mark, 200, 128, 2);
  playrumbleonposition("grenade_rumble", mark);
  wait 1;

  if(isDefined(player)) {
    sprinkler namespace_83eb6304::function_3ecfde67("sprinkler_active");
    sprinkler thread function_922745a1(player);
    timeout = player namespace_1c2a96f9::function_4808b985(10);
    player waittilltimeout(timeout, #"disconnect");
  }

  sprinkler notify(#"hash_1e744934a54fe4bc");
  sprinkler namespace_83eb6304::turnofffx("sprinkler_active");
  wait 2;
  sprinkler namespace_e32bb68::function_3a59ec34("evt_doa_pickup_sprinkler_takeoff");
  sprinkler namespace_83eb6304::function_3ecfde67("sprinkler_takeoff");
  sprinkler moveto(var_497e327b, 0.5);
  sprinkler waittilltimeout(1, #"movedone");
  sprinkler delete();
}