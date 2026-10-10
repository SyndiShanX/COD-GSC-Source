/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4469d6c09568a93e.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_sira_ob_interactions_essence_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_sira_ob_interactions_essence_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_sira_ob_interactions_essence_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_sira_ob_interactions_essence_cs");

  if(!cs_is_starttime()) {
    endcreatescript(s);
  }
}

function cs_return_and_wait_for_flag(us, s, cf) {
  level endon("game_ended");
  wait_for_cs_flag(cf);

  if(!isDefined(us)) {
    us = "pfx";
  }

  s cs_setup_arrays(us, "mp_jup_sira_ob_interactions_essence_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_sira_ob_interactions_essence_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-41724.2, -19509.8, 440), (358.88, 160.93, -0.84));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-37215.1, -13422.2, 400), (0, 352.7, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-31837.8, -13661.6, 674), (0, 61.9, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-31584.1, -15522.7, 256), (0, 156.4, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-29636.7, -15457.8, 487.2), (0, 108.2, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-31047.9, -18802.9, 536), (0, 24.1, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-27612.9, -20518.6, 768), (0, 49.2, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-24611.9, -20267.6, 816), (0, 340.2, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-23368.8, -21066.6, 352), (0, 268.2, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-42029.2, -18024.6, 264), (0, 138, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-45035.7, -17676.4, 264), (0, 105.4, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-39018.1, -20502, 1244.38), (350.95, 236.61, -7.63));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-37720.4, -15492.1, 400), (0, 264.5, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-47635.2, -19003.5, 388), (0, 335, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-40683.2, -25503.5, 272), (0, 60.8, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-41129.9, -27010.5, 263), (0, 334, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-35256.3, -26743.6, 514), (0, 241.43, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-27781, -24442.2, 432), (0, 160.93, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-25665.8, -24087.9, 544), (0, 135.5, 0));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_interactions_essence_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-40427.1, -17435.4, 686.43), (0.53, 288.75, -11.8));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_sira_ob_interactions_essence_cs");
}