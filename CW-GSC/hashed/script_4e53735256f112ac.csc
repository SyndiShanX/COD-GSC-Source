/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4e53735256f112ac.csc
***********************************************/

#using script_101d8280497ff416;
#using script_1e30f5109f6bf48c;
#using script_37560a24283a601;
#using script_68ae4d25b2c90f7d;
#using script_7b5224fe73522c;
#using script_7c727635e50af640;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_inventory_util;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_1b527536;

function private autoexec __init__system__() {
  system::register(#"hash_13a43d760497b54d", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_9bff3a72 = getgametypesetting(#"hash_7dedd27bf994a9a9");

  if(!is_true(level.var_9bff3a72)) {
    return;
  }

  level.var_1b527536 = array(#"frost_blast", #"frost_blast_1", #"frost_blast_2", #"frost_blast_3", #"frost_blast_4", #"frost_blast_5", #"heal_aoe", #"heal_aoe_1", #"heal_aoe_2", #"heal_aoe_3", #"heal_aoe_4", #"heal_aoe_5", #"energy_mine", #"energy_mine_1", #"energy_mine_2", #"energy_mine_3", #"energy_mine_4", #"energy_mine_5", #"aether_shroud", #"aether_shroud_1", #"aether_shroud_2", #"aether_shroud_3", #"aether_shroud_4", #"aether_shroud_5", #"ring_of_fire", #"ring_of_fire_1", #"ring_of_fire_2", #"ring_of_fire_3", #"ring_of_fire_4", #"ring_of_fire_5", #"hash_55569355da0f0f68", #"hash_43e326396554e18c", #"hash_43e329396554e6a5", #"hash_43e328396554e4f2", #"hash_43e323396554dc73", #"hash_43e322396554dac0", #"toxic_growth", #"toxic_growth_1", #"toxic_growth_2", #"toxic_growth_3", #"toxic_growth_4", #"toxic_growth_5", #"lightning_links", #"lightning_links_1", #"lightning_links_2", #"lightning_links_3", #"lightning_links_4", #"lightning_links_5");
  clientfield::register_clientuimodel("hud_items.ammoCooldowns.fieldUpgrade", #"hud_items", [#"hash_2f126bd99a74de8b", #"fieldupgrade"], 1, 5, "float", undefined, 0, 0);
  clientfield::register("toplayer", "field_upgrade_selected", 1, 6, "int", &function_473fedfd, 0, 0);
  clientfield::register("allplayers", "field_upgrade_fired", 1, 4, "counter", &function_1079747f, 0, 0);
  clientfield::function_91cd7763("material", "zm_field_upgrade_loadout.overrideImage", #"zm_field_upgrade_loadout", #"overrideimage", 16000, undefined, 0, 0);
}

function function_473fedfd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_64774ae3 = undefined;

  if(bwastimejump > 0) {
    var_64774ae3 = level.var_1b527536[bwastimejump - 1];
  }

  if(!isDefined(var_64774ae3)) {
    var_64774ae3 = # "";
  }

  model = function_1df4c3b0(fieldname, #"zm_field_upgrade_loadout");
  setuimodelvalue(getuimodel(model, "count"), 0);
  setuimodelvalue(getuimodel(model, "id"), var_64774ae3);
}

function function_1079747f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  wait 0.3;

  switch (bwastimejump) {
    case 1:
      var_5f8075ff = # "hash_48008a3a2268e196";
      var_c785352b = # "hash_47f99e3a2262e4e4";
      break;
    case 2:
      var_5f8075ff = # "hash_6754f5f14b55f3ff";
      var_c785352b = # "hash_674f09f14b51aa4d";
      break;
    case 3:
      var_5f8075ff = # "hash_48e29537fcb81599";
      var_c785352b = # "hash_48e9a137fcbe48ab";
      break;
    case 4:
      var_5f8075ff = # "hash_7238cf4ee4d6c516";
      var_c785352b = # "hash_7231e34ee4d0c864";
      break;
    case 5:
      var_5f8075ff = # "hash_4c83572625d08ca";
      var_c785352b = # "hash_4c22972625888b8";
      break;
    case 6:
      var_5f8075ff = # "hash_79a0e1fa0ed24c50";
      var_c785352b = # "hash_79a6edfa0ed6cc62";
      break;
    case 7:
      var_5f8075ff = # "hash_5371aaf87d10f74a";
      var_c785352b = # "hash_536b9ef87d0c7738";
      break;
    case 8:
      break;
  }

  if(isDefined(self.var_75fbe496)) {
    stopfx(fieldname, self.var_75fbe496);
    self.var_75fbe496 = undefined;
  }

  if(isDefined(self.var_410de60b)) {
    stopfx(fieldname, self.var_410de60b);
    self.var_410de60b = undefined;
  }

  if(isDefined(var_5f8075ff) && isDefined(var_c785352b)) {
    if(zm_utility::function_f8796df3(fieldname)) {
      if(viewmodelhastag(fieldname, "tag_fx_05")) {
        self.var_75fbe496 = playviewmodelfx(fieldname, var_5f8075ff, "tag_fx_05");
      }

      return;
    }

    self util::waittill_dobj(fieldname);

    if(self haspart(fieldname, "tag_fx_05")) {
      self.var_410de60b = util::playFXOnTag(fieldname, var_c785352b, self, "tag_fx_05");
    }
  }
}