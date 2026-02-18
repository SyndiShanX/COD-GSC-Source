/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\weapons.csc
***********************************************/

#using script_2c8f0cd222d353a3;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#namespace weapons;

function init_shared() {
  level.weaponnone = getweapon(#"none");
  clientfield::register_clientuimodel("hudItems.pickupHintWeaponIndex", #"hud_items", #"pickuphintweaponindex", 1, 10, "int", &function_160c9d99, 0, 0);
  namespace_daf1661f::init();
  callback::on_localclient_connect(&on_localclient_connect);
}

function private on_localclient_connect(localclientnum) {
  if(!isDefined(level.var_d46a9367)) {
    level.var_d46a9367 = [];
  }

  objid = util::getnextobjid(localclientnum);
  objective_add(localclientnum, objid, "invisible", #"weapon_pickup");
  objective_setprogress(localclientnum, objid, 0);
  objective_setstate(localclientnum, objid, "invisible");
  level.var_d46a9367[localclientnum] = objid;
}

function function_160c9d99(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_d46a9367)) {
    level.var_d46a9367 = [];
  }

  objid = level.var_d46a9367[fieldname];

  if(!isDefined(objid)) {
    return;
  }

  if(bwastimejump) {
    var_9b882d22 = function_ee839fac(fieldname);

    if(isDefined(var_9b882d22)) {
      objective_setposition(fieldname, objid, var_9b882d22.origin);
    }

    objective_setstate(fieldname, objid, "active");
    objective_setgamemodeflags(fieldname, objid, 0);
    return;
  }

  objective_setstate(fieldname, objid, "invisible");
}