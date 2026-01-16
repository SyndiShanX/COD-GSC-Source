/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\fr.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace fr;

function main() {
  callback::on_localclient_connect( & on_player_connect);
  clientfield::register("world", "freerun_state", 1, 3, "int", & freerunstatechanged, 0, 0);
  clientfield::register("world", "freerun_retries", 1, 16, "int", & freerunretriesupdated, 0, 0);
  clientfield::register("world", "freerun_faults", 1, 16, "int", & freerunfaultsupdated, 0, 0);
  clientfield::register("world", "freerun_startTime", 1, 31, "int", & freerunstarttimeupdated, 0, 0);
  clientfield::register("world", "freerun_finishTime", 1, 31, "int", & freerunfinishtimeupdated, 0, 0);
  clientfield::register("world", "freerun_bestTime", 1, 31, "int", & freerunbesttimeupdated, 0, 0);
  clientfield::register("world", "freerun_timeAdjustment", 1, 31, "int", & freeruntimeadjustmentupdated, 0, 0);
  clientfield::register("world", "freerun_timeAdjustmentNegative", 1, 1, "int", & freeruntimeadjustmentsignupdated, 0, 0);
  clientfield::register("world", "freerun_bulletPenalty", 1, 16, "int", & freerunbulletpenaltyupdated, 0, 0);
  clientfield::register("world", "freerun_pausedTime", 1, 31, "int", & freerunpausedtimeupdated, 0, 0);
  clientfield::register("world", "freerun_checkpointIndex", 1, 7, "int", & freeruncheckpointupdated, 0, 0);
}

function on_player_connect(localclientnum) {
  allowactionslotinput(localclientnum);
  allowscoreboard(localclientnum, 0);
}

function freerunstatechanged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  controllermodel = getuimodelforcontroller(localclientnum);
  statemodel = createuimodel(controllermodel, "FreeRun.runState");
  setuimodelvalue(statemodel, newval);
}

function freerunretriesupdated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  controllermodel = getuimodelforcontroller(localclientnum);
  retriesmodel = createuimodel(controllermodel, "FreeRun.freeRunInfo.retries");
  setuimodelvalue(retriesmodel, newval);
}

function freerunfaultsupdated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  controllermodel = getuimodelforcontroller(localclientnum);
  faultsmodel = createuimodel(controllermodel, "FreeRun.freeRunInfo.faults");
  setuimodelvalue(faultsmodel, newval);
}

function freerunstarttimeupdated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  controllermodel = getuimodelforcontroller(localclientnum);
  model = createuimodel(controllermodel, "FreeRun.startTime");
  setuimodelvalue(model, newval);
}

function freerunfinishtimeupdated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  controllermodel = getuimodelforcontroller(localclientnum);
  model = createuimodel(controllermodel, "FreeRun.finishTime");
  setuimodelvalue(model, newval);
}

function freerunbesttimeupdated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  controllermodel = getuimodelforcontroller(localclientnum);
  model = createuimodel(controllermodel, "FreeRun.freeRunInfo.bestTime");
  setuimodelvalue(model, newval);
}

function freeruntimeadjustmentupdated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  controllermodel = getuimodelforcontroller(localclientnum);
  model = createuimodel(controllermodel, "FreeRun.timer.timeAdjustment");
  setuimodelvalue(model, newval);
}

function freeruntimeadjustmentsignupdated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  controllermodel = getuimodelforcontroller(localclientnum);
  model = createuimodel(controllermodel, "FreeRun.timer.timeAdjustmentNegative");
  setuimodelvalue(model, newval);
}

function freerunbulletpenaltyupdated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  controllermodel = getuimodelforcontroller(localclientnum);
  bulletpenaltymodel = createuimodel(controllermodel, "FreeRun.freeRunInfo.bulletPenalty");
  setuimodelvalue(bulletpenaltymodel, newval);
}

function freerunpausedtimeupdated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  controllermodel = getuimodelforcontroller(localclientnum);
  model = createuimodel(controllermodel, "FreeRun.pausedTime");
  setuimodelvalue(model, newval);
}

function freeruncheckpointupdated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  controllermodel = getuimodelforcontroller(localclientnum);
  model = createuimodel(controllermodel, "FreeRun.freeRunInfo.activeCheckpoint");
  setuimodelvalue(model, newval);
}

function onprecachegametype() {}

function onstartgametype() {}