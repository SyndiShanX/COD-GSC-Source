/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_4dac3680f88a01c3.gsc
*****************************************************/

#using scripts\asm\asm;
#using scripts\asm\gesture\script_funcs;
#using scripts\common\notetrack;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace namespace_6ecc19f3ac5deab;
#using_animtree("*xmG4\x1e\x14\xb1\xc2u_!\xf5");

function ai_gesture_stop(blendout_time) {
  self notify("\xdc\xdd0\xcb,\xa5\x97\x83mY;\x89N\xec\x1f\xcc\xfa\x19>\x9e\x1b\xb2");
  self notify("oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdeJ/\xbb\xb3Z\v\x7f\x8a\xef`!\x04\xa3\x87\xbc\xf4\xef\x1d\xd1");
  self endon("\xdc\xdd0\xcb,\xa5\x97\x83mY;\x89N\xec\x1f\xcc\xfa\x19>\x9e\x1b\xb2");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  if(isDefined(self.anim_getrootfunc) && isDefined(self.old_root)) {
    reset_root();
  }

  if(isDefined(self.anim_getrootfunc) && !isDefined(self.old_root)) {
    self.anim_getrootfunc = undefined;
  }

  if(isDefined(blendout_time)) {
    blend_time = blendout_time;
  } else {
    blend_time = 0.25;
  }

  if(!isDefined(self.is_head_tracking)) {
    return;
  }

  start_time = gettime() / 1000;
  var_7b7f040d8e2f71d = self getanimweight(self.head_center_anim);
  var_9a4cffc012761f96 = self getanimweight(self.head_right_anim);
  var_5b007ea7c1fdd1ef = self getanimweight(self.head_left_anim);
  var_de8c59382ae1b20e = self getanimweight(self.head_rightback_anim);
  var_94309ef5814968c1 = self getanimweight(self.head_leftback_anim);
  var_b9ac2b2aaef4a330 = self getanimweight(%f\n4\x99\xe6\x95p`\xf7\xf7\fBV\x8b\xf3p\xa6 );
var_6fff36131186d0dc = self getanimweight(%Y\x97{<\xd9\xe7H\xebK\b\xf7\xda\x9fz );
var_ae5c2bf86729fd22 = self getanimweight(%\xfe.\x9em\xccz\xb1N\xc5\xcb\xd2\xd5\x89}\xa8\x8dC\xdbdS\xe8\xd2A6 );
var_22db1b84e4acf555 = self getanimweight(%\xb9u\x1cx\xf1W\x7f|da\x83\xcf\xbdb?\xe5\xf5\xceU0J\xe1i0\x18 );
var_9e4e301e0bb5739b = self getanimweight(%6\xbd{\xd6\xc2G\xfa\x1a\x95\x85\x8c\xf5a\xc8F7 );

while( gettime() / 1000 - start_time < blendout_time )
{
norm_val = ( gettime() / 1000 - start_time ) / blendout_time;
norm_val = smoothstep( 0, 1, norm_val );
var_145ca8528e85ddb = lerp_float( var_7b7f040d8e2f71d, 1, norm_val );
var_8d667093866da24 = lerp_float( var_9a4cffc012761f96, 0, norm_val );
var_26c33fa73f9b92c5 = lerp_float( var_5b007ea7c1fdd1ef, 0, norm_val );
var_1c3c9874562ba784 = lerp_float( var_de8c59382ae1b20e, 0, norm_val );
var_df02f8c686af6e7 = lerp_float( var_94309ef5814968c1, 0, norm_val );
var_aca75e6e398fe67e = lerp_float( var_b9ac2b2aaef4a330, 0, norm_val );
var_b3ac08aa53081f5e = lerp_float( var_6fff36131186d0dc, 0, norm_val );
var_91072dd7558966a8 = lerp_float( var_ae5c2bf86729fd22, 0, norm_val );
var_9221e27dffc1603 = lerp_float( var_22db1b84e4acf555, 0, norm_val );
var_eee2f2a14ea79d61 = lerp_float( var_9e4e301e0bb5739b, 0, norm_val );
self setanimlimited( self.head_center_anim, var_145ca8528e85ddb, 0.05 );
self setanimlimited( self.head_right_anim, var_8d667093866da24, 0.05 );
self setanimlimited( self.head_left_anim, var_26c33fa73f9b92c5, 0.05 );
self setanimlimited( self.head_rightback_anim, var_1c3c9874562ba784, 0.05 );
self setanimlimited( self.head_leftback_anim, var_df02f8c686af6e7, 0.05 );
self setanimlimited(%f\n4\x99\xe6\x95p`\
    xf7\xf7\fBV\x8b\xf3p\xa6, var_aca75e6e398fe67e, 0.05);
  self setanimlimited(%Y\x97 {
      <
      \xd9\xe7H\xebK\b\xf7\xda\x9fz, var_b3ac08aa53081f5e, 0.05); self setanimlimited(%\xfe.\x9em\xccz\xb1N\xc5\xcb\xd2\xd5\x89
    }\
    xa8\x8dC\xdbdS\xe8\xd2A6, var_91072dd7558966a8, 0.05);
  self setanimlimited(%\xb9u\x1cx\xf1W\x7f | da\x83\xcf\xbdb ? \xe5\xf5\xceU0J\xe1i0\x18, var_9221e27dffc1603, 0.05);
  self setanimlimited(%6\xbd {
      \
      xd6\xc2G\xfa\x1a\x95\x85\x8c\xf5a\xc8F7, var_eee2f2a14ea79d61, 0.05); wait 0.05;
  }

  self setanimlimited(self.head_center_anim, 0, 0.05);
  self setanimlimited(self.head_right_anim, 0, 0.05);
  self setanimlimited(self.head_left_anim, 0, 0.05);
  self setanimlimited(self.head_rightback_anim, 0, 0.05);
  self setanimlimited(self.head_leftback_anim, 0, 0.05);
  self setanimlimited(%f\n4\x99\xe6\x95p`\xf7\xf7\fBV\x8b\xf3p\xa6, 0, 0.05 );
self setanimlimited(%Y\x97{<\xd9\xe7H\xebK\b\xf7\xda\x9fz, 0, 0.05 );
self setanimlimited(%\xfe.\x9em\xccz\xb1N\xc5\xcb\xd2\xd5\x89}\xa8\x8dC\xdbdS\xe8\xd2A6, 0, 0.05 );
self setanimlimited(%\xb9u\x1cx\xf1W\x7f|da\x83\xcf\xbdb?\xe5\xf5\xceU0J\xe1i0\x18, 0, 0.05 );
self setanimlimited(%6\xbd{\xd6\xc2G\xfa\x1a\x95\x85\x8c\xf5a\xc8F7, 0, 0.05 );
self clearanim(%f\n4\x99\xe6\x95p`\
    xf7\xf7\fBV\x8b\xf3p\xa6, 0.05);
  self clearanim(%Y\x97 {
      <
      \xd9\xe7H\xebK\b\xf7\xda\x9fz, 0.05); self.is_head_tracking = undefined;
  }

  function ai_gesture_eyes_stop(blendout_time) {
    self endon("\x1e\xfd\xd1\xa2\a");
    self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
    self notify("c\x96\xa2v?s\xea\xfc\x96\xd8B\xa8\x7f\xeby\xcc");

    if(isDefined(blendout_time)) {
      blend_time = blendout_time;
    } else {
      blend_time = 0.25;
    }

    self clearanim(%\x12L
    }\
    xd9\x97\x1cR\x94\x88o\x0f\x84\x1f\xc3\xfa\xaaQ\x87`, blend_time );
self clearanim(%\xac\xbc\x95\x9b}\xc6oo\xda\xfa\xd5\x0e\x19\xed\xbb\x9b, blend_time );
self clearanim(%C\xb7\xa7]\xcb\x93\x82\xf7\x7fw\xca;\x7f\x87\xe9|\xc0\x9d\xe7\xae\x1a\xc7\x94\xb2, blend_time );
self clearanim(%Ax\xf3\xd9\xaa/6\x12G\xdd4\xfa\xfd\x12T\xe5\xa7F\xabr\xca(\xdf\x82A\r\xfb, blend_time );
self clearanim(%\x1fjh3\xc9\x06\xe9\x8f\x9b\xcf\xa0\"\x99pq\x19\xa2\x81\b\xfc\xe2\xef\x91, blend_time );
self clearanim(%\x89D\xa8\xe1\xf3%\x8c\xd2\x94\xa5\xce\xb7\x1c\x9b \x911\xa2\xff0\x7f\xe4\xfa\xf2L\x14\xb8\xcd, blend_time );
self clearanim(%g\\\x8a'\x80Lt@\x8d\x13, blend_time );
self.is_eye_tracking = undefined;
}

function ai_gesture_lookat_weight_down( blend_time )
{
self endon( "\x1e\xfd\xd1\xa2\a" );
self endon( "oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4" );
self endon( "):A\x05\xa3x\xc3\xf2Dp\xb2^\xd1u" );
self notify( "\x17UM'\xee\xfa\xd5:\xb2\b|\xd6\x18\xc6&\xcd" );
self endon( "\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19" );

if( isDefined( self.blend_down_in_progress ) )
{
return;
}

blendout_time = blend_time;
self.blend_down_in_progress = 1;
self.blend_up_in_progress = undefined;
start_time = gettime() / 1000;
var_b9ac2b2aaef4a330 = self getanimweight(%f\n4\x99\xe6\x95p`\
    xf7\xf7\fBV\x8b\xf3p\xa6);
  var_6fff36131186d0dc = self getanimweight(%Y\x97 {
      <
      \xd9\xe7H\xebK\b\xf7\xda\x9fz); var_ae5c2bf86729fd22 = self getanimweight(%\xfe.\x9em\xccz\xb1N\xc5\xcb\xd2\xd5\x89
    }\
    xa8\x8dC\xdbdS\xe8\xd2A6);
  var_22db1b84e4acf555 = self getanimweight(%\xb9u\x1cx\xf1W\x7f | da\x83\xcf\xbdb ? \xe5\xf5\xceU0J\xe1i0\x18);
  var_9e4e301e0bb5739b = self getanimweight(%6\xbd {
      \
      xd6\xc2G\xfa\x1a\x95\x85\x8c\xf5a\xc8F7);

    while(gettime() / 1000 - start_time < blendout_time) {
      norm_val = (gettime() / 1000 - start_time) / blendout_time;
      norm_val = smoothstep(0, 1, norm_val);
      var_aca75e6e398fe67e = lerp_float(var_b9ac2b2aaef4a330, 0, norm_val);
      var_b3ac08aa53081f5e = lerp_float(var_6fff36131186d0dc, 0, norm_val);
      var_91072dd7558966a8 = lerp_float(var_ae5c2bf86729fd22, 0, norm_val);
      var_9221e27dffc1603 = lerp_float(var_22db1b84e4acf555, 0, norm_val);
      var_eee2f2a14ea79d61 = lerp_float(var_9e4e301e0bb5739b, 0, norm_val);
      self setanimlimited(%f\n4\x99\xe6\x95p`\xf7\xf7\fBV\x8b\xf3p\xa6, var_aca75e6e398fe67e, 0.05 );
self setanimlimited(%Y\x97{<\xd9\xe7H\xebK\b\xf7\xda\x9fz, var_b3ac08aa53081f5e, 0.05 );
self setanimlimited(%\xfe.\x9em\xccz\xb1N\xc5\xcb\xd2\xd5\x89}\xa8\x8dC\xdbdS\xe8\xd2A6, var_91072dd7558966a8, 0.05 );
self setanimlimited(%\xb9u\x1cx\xf1W\x7f|da\x83\xcf\xbdb?\xe5\xf5\xceU0J\xe1i0\x18, var_9221e27dffc1603, 0.05 );
self setanimlimited(%6\xbd{\xd6\xc2G\xfa\x1a\x95\x85\x8c\xf5a\xc8F7, var_eee2f2a14ea79d61, 0.05 );
wait 0.05;
}

self setanimlimited(%f\n4\x99\xe6\x95p`\
        xf7\xf7\fBV\x8b\xf3p\xa6, 0, 0.05);
      self setanimlimited(%Y\x97 {
          <
          \xd9\xe7H\xebK\b\xf7\xda\x9fz, 0, 0.05); self setanimlimited(%\xfe.\x9em\xccz\xb1N\xc5\xcb\xd2\xd5\x89
        }\
        xa8\x8dC\xdbdS\xe8\xd2A6, 0, 0.05);
      self setanimlimited(%\xb9u\x1cx\xf1W\x7f | da\x83\xcf\xbdb ? \xe5\xf5\xceU0J\xe1i0\x18, 0, 0.05);
      self setanimlimited(%6\xbd {
          \
          xd6\xc2G\xfa\x1a\x95\x85\x8c\xf5a\xc8F7, 0, 0.05); self.blend_down_in_progress = undefined;
      }

      function ai_gesture_lookat_weight_up(blend_time) {
        self endon("\x1e\xfd\xd1\xa2\a");
        self endon("oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4");
        self endon("\x17UM'\xee\xfa\xd5:\xb2\b|\xd6\x18\xc6&\xcd");
        self notify("):A\x05\xa3x\xc3\xf2Dp\xb2^\xd1u");
        self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

        if(isDefined(self.blend_up_in_progress)) {
          return;
        }

        blendout_time = blend_time;
        self.blend_up_in_progress = 1;
        self.blend_down_in_progress = undefined;
        start_time = gettime() / 1000;
        var_b9ac2b2aaef4a330 = self getanimweight(%f\n4\x99\xe6\x95p`\xf7\xf7\fBV\x8b\xf3p\xa6 );
var_6fff36131186d0dc = self getanimweight(%Y\x97{<\xd9\xe7H\xebK\b\xf7\xda\x9fz );
var_ae5c2bf86729fd22 = self getanimweight(%\xfe.\x9em\xccz\xb1N\xc5\xcb\xd2\xd5\x89}\xa8\x8dC\xdbdS\xe8\xd2A6 );
var_22db1b84e4acf555 = self getanimweight(%\xb9u\x1cx\xf1W\x7f|da\x83\xcf\xbdb?\xe5\xf5\xceU0J\xe1i0\x18 );
var_9e4e301e0bb5739b = self getanimweight(%6\xbd{\xd6\xc2G\xfa\x1a\x95\x85\x8c\xf5a\xc8F7 );

while( gettime() / 1000 - start_time < blendout_time )
{
norm_val = ( gettime() / 1000 - start_time ) / blendout_time;
norm_val = smoothstep( 0, 1, norm_val );
var_aca75e6e398fe67e = lerp_float( var_b9ac2b2aaef4a330, 1, norm_val );
var_b3ac08aa53081f5e = lerp_float( var_6fff36131186d0dc, 1, norm_val );
var_91072dd7558966a8 = lerp_float( var_ae5c2bf86729fd22, 10, norm_val );
var_9221e27dffc1603 = lerp_float( var_22db1b84e4acf555, 10, norm_val );
var_eee2f2a14ea79d61 = lerp_float( var_9e4e301e0bb5739b, 0, norm_val );
self setanimlimited(%f\n4\x99\xe6\x95p`\
          xf7\xf7\fBV\x8b\xf3p\xa6, var_aca75e6e398fe67e, 0.05);
        self setanimlimited(%Y\x97 {
            <
            \xd9\xe7H\xebK\b\xf7\xda\x9fz, var_b3ac08aa53081f5e, 0.05); self setanimlimited(%\xfe.\x9em\xccz\xb1N\xc5\xcb\xd2\xd5\x89
          }\
          xa8\x8dC\xdbdS\xe8\xd2A6, var_91072dd7558966a8, 0.05);
        self setanimlimited(%\xb9u\x1cx\xf1W\x7f | da\x83\xcf\xbdb ? \xe5\xf5\xceU0J\xe1i0\x18, var_9221e27dffc1603, 0.05);
        self setanimlimited(%6\xbd {
            \
            xd6\xc2G\xfa\x1a\x95\x85\x8c\xf5a\xc8F7, var_eee2f2a14ea79d61, 0.05); wait 0.05;
        }

        self setanimlimited(%f\n4\x99\xe6\x95p`\xf7\xf7\fBV\x8b\xf3p\xa6, 1, 0.05 );
self setanimlimited(%Y\x97{<\xd9\xe7H\xebK\b\xf7\xda\x9fz, 1, 0.05 );
self setanimlimited(%\xfe.\x9em\xccz\xb1N\xc5\xcb\xd2\xd5\x89}\xa8\x8dC\xdbdS\xe8\xd2A6, 10, 0.05 );
self setanimlimited(%\xb9u\x1cx\xf1W\x7f|da\x83\xcf\xbdb?\xe5\xf5\xceU0J\xe1i0\x18, 10, 0.05 );
self setanimlimited(%6\xbd{\xd6\xc2G\xfa\x1a\x95\x85\x8c\xf5a\xc8F7, 1, 0.05 );
self.blend_up_in_progress = undefined;
}

function ai_gesture_torso_stop( blendout_time )
{
self endon( "\x1e\xfd\xd1\xa2\a" );
self endon( "\xcd\x8e\xc2\x9c:\xeb\xec+nt\xea\xe4Y}\x8e\xbd9\xb9o\xebl\xb7\xb7[\xb0\xd1" );
self endon( "\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19" );
self notify( "\x9c\xb4\x13\x13\xbc-E\xae\xf9\x0e\x18;g\xf5\xc2R\xf9\xe0" );

if( !isDefined( self.is_torso_tracking ) )
{
return;
}

if( isDefined( blendout_time ) )
{
blend_time = blendout_time;
}
else
{
blend_time = 0.25;
}

start_time = gettime() / 1000;
var_7b7f040d8e2f71d = self getanimweight( self.torso_center_anim );
var_9a4cffc012761f96 = self getanimweight( self.torso_right_anim );
var_5b007ea7c1fdd1ef = self getanimweight( self.torso_left_anim );
var_de8c59382ae1b20e = self getanimweight( self.torso_rightback_anim );
var_94309ef5814968c1 = self getanimweight( self.torso_leftback_anim );

while( gettime() / 1000 - start_time < blendout_time )
{
norm_val = ( gettime() / 1000 - start_time ) / blendout_time;
norm_val = smoothstep( 0, 1, norm_val );
var_145ca8528e85ddb = lerp_float( var_7b7f040d8e2f71d, 1, norm_val );
var_8d667093866da24 = lerp_float( var_9a4cffc012761f96, 0, norm_val );
var_26c33fa73f9b92c5 = lerp_float( var_5b007ea7c1fdd1ef, 0, norm_val );
var_1c3c9874562ba784 = lerp_float( var_de8c59382ae1b20e, 0, norm_val );
var_df02f8c686af6e7 = lerp_float( var_94309ef5814968c1, 0, norm_val );
self setanimlimited( self.torso_center_anim, var_145ca8528e85ddb, 0.05 );
self setanimlimited( self.torso_right_anim, var_8d667093866da24, 0.05 );
self setanimlimited( self.torso_left_anim, var_26c33fa73f9b92c5, 0.05 );
self setanimlimited( self.torso_rightback_anim, var_1c3c9874562ba784, 0.05 );
self setanimlimited( self.torso_leftback_anim, var_df02f8c686af6e7, 0.05 );
wait 0.05;
}

self setanimlimited( self.torso_center_anim, 1, 0.05 );
self setanimlimited( self.torso_right_anim, 0, 0.05 );
self setanimlimited( self.torso_left_anim, 0, 0.05 );
self setanimlimited( self.torso_rightback_anim, 0, 0.05 );
self setanimlimited( self.torso_leftback_anim, 0, 0.05 );
self clearanim(%\xda!\x95\x99A\x04)-\x03\xdbGt\x14\\\x13\x14\x84k>O, blendout_time );
self.is_torso_tracking = undefined;
}

function ai_gesture_lookat( lookat_target, catchup_speed, blend_in_time )
{
self endon( "\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19" );

if( !isDefined( self ) )
{
return;
}

if( isDefined( self.is_head_tracking ) )
{
ai_gesture_stop( 0.25 );
wait 0.25;
}

self endon( "\x1e\xfd\xd1\xa2\a" );
self endon( "oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4" );
self notify( "\xdeJ/\xbb\xb3Z\v\x7f\x8a\xef`!\x04\xa3\x87\xbc\xf4\xef\x1d\xd1 " );

          if(isai(self)) {
            state = asm::asm_getcurrentstate(self.asmname);
          } else {
            state = undefined;
          }

          if(isDefined(self.anim_getrootfunc)) {
            store_old_root();
          }

          if(!isDefined(self.anim_getrootfunc)) {
            self.anim_getrootfunc = &set_root;
          }

          if(isDefined(blend_in_time)) {
            self.blend_in_time = blend_in_time;
          } else {
            self.blend_in_time = 0.7;
          }

          self.look_leftright_anim = undefined; self.look_updown_anim = undefined; self.lookat_aquired = 0;

          if(isDefined(catchup_speed)) {
            self.gesture_catchup_speed = clamp(catchup_speed, 0.25, 4);
          } else {
            self.gesture_catchup_speed = 0.5;
          }

          self.look_leftright_anim = % Ia - \xf0U\xe2\xdf + \xd9\x05\xb3\t\xaa\xa2\xfd % < ;\x8b\x9d5\x024\xe9\b\x8aj\x93\xcd; h;; self.look_updown_anim = % U: \xe6n\xfe`3&\xf6\xb7\x185kK\xcbm<\x01\xa9\x04\xfe\b\xbd\xf1'ttQ;
self.head_center_anim = %V\xcdY1)\x90\xefLe\xe2\xc00\x9a@\x8f\xb5;
self.head_right_anim = %G\xf9\xbb8\xdb\xfbZ\x96\xf3\x1b\xd9\xf7\xbc\x94xW\xa6\xe3;
self.head_left_anim = %\xe8j\xefC\xc4eM\xcfr\xd5\xf2\x8d@S(\x84\xec;
self.head_rightback_anim = %\xdf\xf8\xc7\xb1|\x9a\xeaj\x1auN\x9ag\xc2\xde\x11\xd3\xe0\xa0\xeb\xe3\xe0;
self.head_leftback_anim = %i`
          i\x1f[Tqq\x0e\xc9\x1a\xbb\x1c\x1b 'X~1\x9d\xec!;
            self.gesture_lookat = lookat_target; thread ai_gesture_head_leftright(); thread ai_gesture_head_updown(); self.is_head_tracking = 1;
          }

          function ai_gesture_eyes_lookat(lookat_target, catchup_speed, blend_in_time) {
            self endon("\x1e\xfd\xd1\xa2\a");
            self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

            if(isDefined(self.is_eye_tracking)) {
              ai_gesture_eyes_stop(0.25);
              wait 0.25;
            }

            if(isDefined(self.anim_getrootfunc)) {
              store_old_root();
            }

            if(!isDefined(self.anim_getrootfunc)) {
              self.anim_getrootfunc = &set_root;
            }

            if(isDefined(blend_in_time)) {
              self.eye_blend_in_time = blend_in_time;
            } else {
              self.eye_blend_in_time = 0.3;
            }

            self.eyes_leftright_anim = undefined;
            self.eyes_updown_anim = undefined;
            self.lookat_aquired = 0;

            if(isDefined(catchup_speed)) {
              self.eye_catchup_speed = clamp(catchup_speed, 0.25, 4);
            } else {
              self.eye_catchup_speed = 2;
            }

            self.eyes_leftright_anim = % E\xd3\x9d\xdbi\xc2v < \xb1\\\xc2\xb6\xde\xad\xc6\xafu\x16\xb6\xff\x82\xe0\x0f\xc2HG\x04\xa7.;
            self.eyes_updown_anim = % 3, \xc6\xd2\v\x8d\xafgY\xe6: u\xc9\xac\xfa6\xbd\xedm_\xba\x832\xddn;
            self.eyes_lookat = lookat_target;
            thread ai_gesture_eyes_leftright();
            thread ai_gesture_eyes_updown();
            self.is_eye_tracking = 1;
          }

          function ai_gesture_lookat_torso(lookat_target, blend_in_time) {
            self endon("\x1e\xfd\xd1\xa2\a");
            self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
            self notify("\xcd\x8e\xc2\x9c:\xeb\xec+nt\xea\xe4Y}\x8e\xbd9\xb9o\xebl\xb7\xb7[\xb0\xd1");

            if(isai(self)) {
              state = asm::asm_getcurrentstate(self.asmname);
            } else {
              state = undefined;
            }

            if(!isDefined(state)) {
              return;
            }

            if(isDefined(self.is_torso_tracking)) {
              ai_gesture_torso_stop(0.25);
              wait 0.25;
            }

            if(isDefined(blend_in_time)) {
              self.blend_in_time = blend_in_time;
            } else {
              self.blend_in_time = 0.7;
            }

            self.torso_leftright_anim = undefined;
            self.lookat_aquired = 0;
            self.torso_center_anim = % \x86\xad\xd7\xb3\xc9\xb92\xafg\x937\xaf\xd8\x857\xbaa6_\xcd\xa3X\xe6\x8c_\xd8\x95s\x8ee\xc9
          }
          Z #\x1be; self.torso_left_anim = % \xef5a\x88\xb8\xcb\xfc < \xf5p\xc8\xd1\xaa\x80\xc5\x06\xa7\xbeq * H\xb2\x90\x9d < \x84\x93X\fA\x94\x8e\xc8\xf5; self.torso_leftback_anim = % i\">\xd7\xcd\rFHz\xe5\xf63p\b\xcf\xda\x98\xe3\xcd\xe5\nGA\xbe\x8a\xd8\xb6\x9b\b\xc4\xbd\xe4I\xfb\xa1\"\xcc\xc1;
          self.torso_right_anim = % \x9f\x9e8T\x9b - Jo\x7fp\xb0\xe7.\xd5\x195\x9f\xa6\x8ff\xbc\x93\xc0\x88_\xc7\xcc ? L < \xeed)\x846;
        self.torso_rightback_anim = % \x1am\xf5;
        Ns\x8c\xd7\xb3\x9c\xb9\xaf\x1b\x85\x9b]\xb06
    }\
    xcd\x8eX\xcd\xc8_\x9c\x96; 4 t\x89\xb0\xd8[\xeb\xa5\x19\x1b\x95; self.gesture_lookat = lookat_target; thread ai_gesture_torso_leftright(); self.is_torso_tracking = 1;
    }

    function set_root() {
      return % \xb7\x1bs\xf8;
    }

    function store_old_root() {
      self.old_root = self.anim_getrootfunc;
    }

    function reset_root() {
      self.anim_getrootfunc = self.old_root;
    }

    function ai_gesture_update_lookat(new_lookat, var_87f6e5f50a805ecd) {
      self endon("\x1e\xfd\xd1\xa2\a");
      self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
      self.gesture_lookat = new_lookat;
      self.is_head_tracking = 1;

      if(isDefined(var_87f6e5f50a805ecd)) {
        var_870fc57237957cad = self.gesture_catchup_speed;
        self.gesture_catchup_speed = var_87f6e5f50a805ecd;
        wait var_87f6e5f50a805ecd * 2;
        self.gesture_catchup_speed = var_870fc57237957cad;
      }
    }

    function ai_gesture_lookat_natural(lookat_target, catchup_speed, blend_in_time, check_range) {
      self endon("C\x98\xb4\x13\xbb\x91\xe1\xa5N@\xca\xfc}\xaeu[5\tz\xc1");
      self endon("oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4");
      self endon("\x1e\xfd\xd1\xa2\a");
      self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

      while(!script_funcs::ai_can_lookat()) {
        wait 0.05;
      }

      while(distance2d(self.origin, lookat_target.origin) > check_range) {
        wait 0.05;
      }

      thread ai_gesture_lookat(lookat_target, catchup_speed, blend_in_time);
      wait blend_in_time;

      while(true) {
        wait randomfloatrange(4, 5);

        if(distance2d(self.origin, lookat_target.origin) <= check_range) {
          thread ai_gesture_lookat_weight_down(1);
          thread ai_gesture_eyes_stop();
        }

        wait randomfloatrange(4, 6);

        while(!script_funcs::ai_can_lookat()) {
          wait 0.05;
        }

        if(distance2d(self.origin, lookat_target.origin) <= check_range) {
          thread ai_gesture_lookat_weight_up(0.5);
          thread ai_gesture_eyes_lookat(lookat_target, 1, 0.2);
        }
      }
    }

    function ai_gesture_update_eyes_lookat(new_lookat, var_87f6e5f50a805ecd) {
      self endon("\x1e\xfd\xd1\xa2\a");
      self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
      self.eyes_lookat = new_lookat;
      self.is_eye_tracking = 1;

      if(isDefined(var_87f6e5f50a805ecd)) {
        var_870fc57237957cad = self.eye_catchup_speed;
        self.eye_catchup_speed = var_87f6e5f50a805ecd;
        wait var_87f6e5f50a805ecd * 2;
        self.eye_catchup_speed = var_870fc57237957cad;
      }
    }

    function ai_gesture_head_leftright() {
      self endon("oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4");
      self endon("\x1e\xfd\xd1\xa2\a");
      self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
      blendout_time = self.blend_in_time;
      start_time = gettime() / 1000;
      var_3a0109b661e8a1a7 = undefined;
      anim_parent = % f\n4\x99\xe6\x95p`\xf7\xf7\fBV\x8b\xf3p\xa6;
fwd_anim = self.head_center_anim;
right_anim = self.head_right_anim;
left_anim = self.head_left_anim;
back_right_anim = self.head_rightback_anim;
back_left_anim = self.head_leftback_anim;
thread _ai_head_weight_blend_in();
var_3a0109b661e8a1a7 = vectortoangles( level.player.origin - self.origin );
self setanimlimited( fwd_anim, 1, self.blend_in_time );
self setanimlimited( right_anim, 0.005, self.blend_in_time );
self setanimlimited( left_anim, 0.005, self.blend_in_time );
self setanimlimited( back_right_anim, 0.005, self.blend_in_time );
self setanimlimited( back_left_anim, 0.005, self.blend_in_time );
var_e6b8d311282ec15d = 0;
var_17fe93aa2ce8e05a = 0;

while( true )
{
if( !isDefined( self ) )
{
return;
}

if( !isDefined( self.gesture_lookat ) )
{
thread ai_gesture_stop( 0.7 );
break;
}

if( isPlayer( self.gesture_lookat ) )
{
lookat = level.player getEye();
}
else if( isai( self.gesture_lookat ) )
{
lookat = self.gesture_lookat getEye();
}
else if( isvector( self.gesture_lookat ) )
{
lookat = self.gesture_lookat;
}
else
{
lookat = self.gesture_lookat.origin;
}

var_eff4a8961c1e0c3b = self gettagangles( "3'4\xc4\xf8l\x16\xdf" ) + ( 0, 0, 0 );
var_22ee72ef79fe89b = self gettagorigin( "3'4\xc4\xf8l\x16\xdf" );
vec_to_player = vectorNormalize( lookat - var_22ee72ef79fe89b );
forward_vec = anglestoright( var_eff4a8961c1e0c3b );
right_vec = anglestoup( var_eff4a8961c1e0c3b );
left_vec = anglestoup( var_eff4a8961c1e0c3b ) * -1;
back_vec = anglestoright( var_eff4a8961c1e0c3b ) * -1;
up_vec = anglesToForward( var_eff4a8961c1e0c3b );
dot_fwd = clamp( vectordot( vec_to_player, forward_vec ), 0.005, 1 );
dot_right = clamp( vectordot( vec_to_player, right_vec ), 0.005, 1 );
dot_left = clamp( vectordot( vec_to_player, left_vec ), 0.005, 1 );
dot_back = clamp( vectordot( vec_to_player, back_vec ), 0.005, 1 );
back_test = 1;

if( math::anglebetweenvectorssigned( forward_vec, vec_to_player, up_vec ) > 0 )
{
back_test = 0;
}

self setanimlimited( right_anim, dot_right, self.gesture_catchup_speed );
self setanimlimited( left_anim, dot_left, self.gesture_catchup_speed );
self setanimlimited( fwd_anim, dot_fwd + 0.005, self.gesture_catchup_speed );

if( back_test )
{
var_e6b8d311282ec15d = math::lerp( var_e6b8d311282ec15d, dot_back, 0.1 );
var_17fe93aa2ce8e05a = math::lerp( var_17fe93aa2ce8e05a, 0.005, 0.1 );
}
else
{
var_e6b8d311282ec15d = math::lerp( var_e6b8d311282ec15d, 0.005, 0.1 );
var_17fe93aa2ce8e05a = math::lerp( var_17fe93aa2ce8e05a, dot_back, 0.1 );
}

self setanimlimited( back_right_anim, var_e6b8d311282ec15d, self.gesture_catchup_speed );
self setanimlimited( back_left_anim, var_17fe93aa2ce8e05a, self.gesture_catchup_speed );
waitframe();
}
}

function _ai_head_weight_blend_in()
{
self endon( "oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4" );
self endon( "\x1e\xfd\xd1\xa2\a" );
self endon( "\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19" );
start_time = gettime() / 1000;
self.blend_up_in_progress = 1;

while( gettime() / 1000 - start_time < self.blend_in_time * 2 )
{
norm_val = ( gettime() / 1000 - start_time ) / self.blend_in_time * 2;
smooth_val = smoothstep( 0, 1, norm_val );
var_12a02c9a52773d60 = smoothstep( 0, 10, norm_val );
weight = lerp_float( 0, 1, smooth_val );
part_weight = lerp_float( 0, 10, smooth_val );
self setanimlimited(%f\n4\x99\xe6\x95p`\
      xf7\xf7\fBV\x8b\xf3p\xa6, weight, 0.2); self setanimlimited(%Y\x97 {
        <
        \xd9\xe7H\xebK\b\xf7\xda\x9fz, weight, 0.2); self setanimlimited(%\xfe.\x9em\xccz\xb1N\xc5\xcb\xd2\xd5\x89
      }\
      xa8\x8dC\xdbdS\xe8\xd2A6, part_weight, 0.2); self setanimlimited(%\xb9u\x1cx\xf1W\x7f | da\x83\xcf\xbdb ? \xe5\xf5\xceU0J\xe1i0\x18, part_weight, 0.2); wait 0.05;
  }

  self setanimlimited(%f\n4\x99\xe6\x95p`\xf7\xf7\fBV\x8b\xf3p\xa6, 1, 0.2 );
self setanimlimited(%Y\x97{<\xd9\xe7H\xebK\b\xf7\xda\x9fz, 1, 0.2 );
self setanimlimited(%\xfe.\x9em\xccz\xb1N\xc5\xcb\xd2\xd5\x89}\xa8\x8dC\xdbdS\xe8\xd2A6, 10, 0.2 );
self setanimlimited(%\xb9u\x1cx\xf1W\x7f|da\x83\xcf\xbdb?\xe5\xf5\xceU0J\xe1i0\x18, 10, 0.2 );
wait 0.05;
self.blend_up_in_progress = undefined;
}

function ai_gesture_head_updown()
{
self endon( "oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4" );
self endon( "\x1e\xfd\xd1\xa2\a" );
self endon( "\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19" );
self setanimlimited(%Y\x97{<\xd9\xe7H\xebK\b\xf7\xda\x9fz, 1, self.blend_in_time );
self setanimlimited( self.look_updown_anim, 1, self.blend_in_time );
self setanimtime( self.look_updown_anim, 0.5 );
var_c2e3ce36da51e7fc = 0.5;

while( true )
{
if( !isDefined( self ) )
{
break;
}

if( isPlayer( self.gesture_lookat ) )
{
offset = 0;

if( level.player getdemeanorviewmodel() == " w%\xe0" )
{
offset = 4.62;
}

lookat = level.player getEye() + anglestoup( self.angles ) * offset;
}
else if( isai( self.gesture_lookat ) )
{
lookat = self.gesture_lookat getEye();
}
else if( isvector( self.gesture_lookat ) )
{
lookat = self.gesture_lookat;
}
else
{
lookat = self.gesture_lookat.origin;
}

var_eff4a8961c1e0c3b = self gettagangles( "3'4\xc4\xf8l\x16\xdf" ) + ( 0, 0, 0 );
var_22ee72ef79fe89b = self gettagorigin( "3'4\xc4\xf8l\x16\xdf" );
guy_pos = undefined;

if( isai( self ) )
{
guy_pos = self getEye();
}
else
{
guy_pos = self gettagorigin( "\xa4\xeb\x12e\x85#" );
}

vec_to_player = vectorNormalize( lookat - guy_pos );
var_75b0a3e6e8b8afcf = anglesToForward( var_eff4a8961c1e0c3b );
var_8b313289ac3153c1 = vectordot( var_75b0a3e6e8b8afcf, vec_to_player );
var_a6331717f3d9b546 = float_remap( var_8b313289ac3153c1, 1, -1, 0, 1 );
var_c2e3ce36da51e7fc += ( var_a6331717f3d9b546 - var_c2e3ce36da51e7fc ) * self.gesture_catchup_speed * 0.3;
var_c2e3ce36da51e7fc = clamp( var_c2e3ce36da51e7fc, 0.1, 0.65 );
set_time_via_rate( self.look_updown_anim, var_c2e3ce36da51e7fc );
waitframe();
}
}

function ai_gesture_eyes_leftright()
{
self endon( "oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4" );
self endon( "\x1e\xfd\xd1\xa2\a" );
self endon( "c\x96\xa2v?s\xea\xfc\x96\xd8B\xa8\x7f\xeby\xcc" );
self endon( "\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19" );
self setanimlimited(%C\xb7\xa7]\xcb\x93\x82\xf7\x7fw\xca;\x7f\x87\xe9|\xc0\x9d\xe7\xae\x1a\xc7\x94\xb2, 10, self.eye_blend_in_time * 2 );
self setanimlimited(%Ax\xf3\xd9\xaa/6\x12G\xdd4\xfa\xfd\x12T\xe5\xa7F\xabr\xca(\xdf\x82A\r\xfb, 10, self.eye_blend_in_time * 2 );
self setanimlimited(%\x12L}\xd9\x97\x1cR\x94\x88o\x0f\x84\x1f\xc3\xfa\xaaQ\x87`, 1, self.eye_blend_in_time);
  self setanimlimited(self.eyes_leftright_anim, 1, self.eye_blend_in_time);
  self setanimtime(self.eyes_leftright_anim, 0.5);
  self setanimrate(self.eyes_leftright_anim, 0);
  var_c2e3ce36da51e7fc = 0;

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(self.eyes_lookat)) {
      ai_gesture_eyes_stop(0.25);
      break;
    }

    if(isPlayer(self.eyes_lookat)) {
      lookat = level.player getEye();
    } else if(isai(self.eyes_lookat)) {
      lookat = self.eyes_lookat getEye();
    } else if(isvector(self.eyes_lookat)) {
      lookat = self.eyes_lookat;
    } else {
      lookat = self.eyes_lookat.origin;
    }

    var_98a17c4eae67a7d9 = self gettagangles("\xa6\xeb\x1ae\x85#");
    var_9492405fb676665 = self gettagorigin("\xa6\xeb\x1ae\x85#");
    var_eff4a8961c1e0c3b = self gettagangles("3'4\xc4\xf8l\x16\xdf") + (0, 90, 0);
    vec_to_player = vectorNormalize(lookat - var_9492405fb676665);
    var_3a5bf5c5f51bc03d = anglestoup(var_98a17c4eae67a7d9);
    var_d17f5c0c6cdb71bc = utility::flatten_vector(vec_to_player);
    var_6a9e68f348f5b728 = utility::flatten_vector(var_3a5bf5c5f51bc03d);
    var_54a30a886f50691d = vectordot(var_6a9e68f348f5b728, var_d17f5c0c6cdb71bc);
    var_a6331717f3d9b546 = float_remap(var_54a30a886f50691d, 1, -1, 0, 1);
    follow_percent = clamp(var_a6331717f3d9b546, 0, 1);
    self setanimtime(self.eyes_leftright_anim, follow_percent);
    waitframe();
  }
}

function ai_gesture_eyes_updown() {
  self endon("oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("c\x96\xa2v?s\xea\xfc\x96\xd8B\xa8\x7f\xeby\xcc");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self setanimlimited(%\xac\xbc\x95\x9b
  }\
  xc6oo\xda\xfa\xd5\x0e\x19\xed\xbb\x9b, 1, self.eye_blend_in_time);
self setanimlimited(self.eyes_updown_anim, 1, self.eye_blend_in_time);
self setanimtime(self.eyes_updown_anim, 0.5);
var_c2e3ce36da51e7fc = 0.5;

while(true) {
  if(!isDefined(self)) {
    break;
  }

  if(isPlayer(self.eyes_lookat)) {
    lookat = level.player getEye();
  } else if(isai(self.eyes_lookat)) {
    lookat = self.eyes_lookat getEye();
  } else if(isvector(self.eyes_lookat)) {
    lookat = self.eyes_lookat;
  } else {
    lookat = self.eyes_lookat.origin;
  }

  var_98a17c4eae67a7d9 = self gettagangles("\xa6\xeb\x1ae\x85#");
  var_9492405fb676665 = self gettagorigin("\xa6\xeb\x1ae\x85#");
  var_eff4a8961c1e0c3b = self gettagangles("3'4\xc4\xf8l\x16\xdf");
  var_7bc6392b37980a2c = anglesToForward(var_98a17c4eae67a7d9);
  vec_to_player = vectorNormalize(lookat - var_9492405fb676665);
  dot_vec = vectordot(var_7bc6392b37980a2c, vec_to_player);
  var_a6331717f3d9b546 = float_remap(dot_vec, 1, -1, 0.3, 0.7);
  follow_percent = clamp(var_a6331717f3d9b546, 0, 1);
  var_c2e3ce36da51e7fc += (follow_percent - var_c2e3ce36da51e7fc) * self.eye_catchup_speed * 0.3;
  var_c2e3ce36da51e7fc = clamp(var_c2e3ce36da51e7fc, 0.1, 0.9);
  set_time_via_rate(self.eyes_updown_anim, var_c2e3ce36da51e7fc);
  waitframe();
}
}

function ai_gesture_torso_leftright() {
  self endon("\x9c\xb4\x13\x13\xbc-E\xae\xf9\x0e\x18;g\xf5\xc2R\xf9\xe0");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  var_3a0109b661e8a1a7 = undefined;
  anim_parent = % \xda!\x95\x99A\x04) - \x03\xdbGt\x14\\\x13\x14\x84k > O;
fwd_anim = self.torso_center_anim;
right_anim = self.torso_right_anim;
left_anim = self.torso_left_anim;
back_right_anim = self.torso_rightback_anim;
back_left_anim = self.torso_leftback_anim;
childthread _ai_torso_weight_blend_in();
var_3a0109b661e8a1a7 = vectortoangles(level.player.origin - self.origin);
self setanimlimited(fwd_anim, 1, 0.05);
self setanimlimited(right_anim, 0, 0.05);
self setanimlimited(left_anim, 0, 0.05);
self setanimlimited(back_right_anim, 0, 0.05);
self setanimlimited(back_left_anim, 0, 0.05);
var_e6b8d311282ec15d = 0;
var_17fe93aa2ce8e05a = 0;

while(true) {
  if(!isDefined(self)) {
    break;
  }

  if(isPlayer(self.gesture_lookat)) {
    lookat = level.player getEye();
  } else if(isai(self.gesture_lookat)) {
    lookat = self.gesture_lookat getEye();
  } else if(isvector(self.gesture_lookat)) {
    lookat = self.gesture_lookat;
  } else {
    lookat = self.gesture_lookat.origin;
  }

  vec_to_player = vectorNormalize(lookat - self.origin);
  forward_vec = anglesToForward(self.angles);
  right_vec = anglestoright(self.angles);
  left_vec = anglestoright(self.angles) * -1;
  back_vec = anglesToForward(self.angles) * -1;
  up_vec = anglestoup(self.angles);
  dot_fwd = clamp(vectordot(vec_to_player, forward_vec), 0, 1);
  dot_right = clamp(vectordot(vec_to_player, right_vec), 0, 1);
  dot_left = clamp(vectordot(vec_to_player, left_vec), 0, 1);
  dot_back = clamp(vectordot(vec_to_player, back_vec), 0, 1);
  back_test = 1;

  if(math::anglebetweenvectorssigned(forward_vec, vec_to_player, up_vec) > 0) {
    back_test = 0;
  }

  self setanimlimited(right_anim, dot_right, 0.2);
  self setanimlimited(left_anim, dot_left, 0.2);
  self setanimlimited(fwd_anim, dot_fwd + 0.005, 0.2);

  if(back_test) {
    var_e6b8d311282ec15d = math::lerp(var_e6b8d311282ec15d, dot_back, 0.1);
    var_17fe93aa2ce8e05a = math::lerp(var_17fe93aa2ce8e05a, 0, 0.1);
  } else {
    var_e6b8d311282ec15d = math::lerp(var_e6b8d311282ec15d, 0, 0.1);
    var_17fe93aa2ce8e05a = math::lerp(var_17fe93aa2ce8e05a, dot_back, 0.1);
  }

  self setanimlimited(back_right_anim, var_e6b8d311282ec15d, 0.2);
  self setanimlimited(back_left_anim, var_17fe93aa2ce8e05a, 0.2);
  waitframe();
}
}

function _ai_torso_weight_blend_in() {
  start_time = gettime() / 1000;

  while(gettime() / 1000 - start_time < self.blend_in_time) {
    norm_val = (gettime() / 1000 - start_time) / self.blend_in_time;
    norm_val = smoothstep(0, 1, norm_val);
    weight = lerp_float(0, 1, norm_val);
    self setanimlimited(%\xda!\x95\x99A\x04) - \x03\xdbGt\x14\\\x13\x14\x84k > O, weight, 0.05);
  wait 0.05;
  waittillframeend();
}

self setanimlimited(%\xda!\x95\x99A\x04) - \x03\xdbGt\x14\\\x13\x14\x84k > O, 1, 0.05);
}

function ai_gesture_blink_loop(blink_interval) {
  self endon("oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  ai_gesture_single_blink();

  while(true) {
    wait randomfloatrange(blink_interval * 0.5, blink_interval);
    self clearanim(%4\xd15\xe1Sz\xedu @\x01\xbaD\xa9\x85\xc6XXr\xfb\xc3P\xab, 0);
    wait 0.05;
    self setanimlimited(%4\xd15\xe1Sz\xedu @\x01\xbaD\xa9\x85\xc6XXr\xfb\xc3P\xab, 1, 0);
    waitframe();
  }
}

function ai_gesture_single_blink() {
  self endon("oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  if(!isDefined(self)) {
    return;
  }

  self setanimlimited(%g\\\x8a '\x80Lt@\x8d\x13, 1, 0 );
    self clearanim(%4\xd15\xe1Sz\xedu @\x01\xbaD\xa9\x85\xc6XXr\xfb\xc3P\xab, 0); wait 0.05; self setanimlimited(%4\xd15\xe1Sz\xedu @\x01\xbaD\xa9\x85\xc6XXr\xfb\xc3P\xab, 1, 0);
  }

  function ai_gesture_point(pointat) {
    self endon("oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4");
    self endon("\x1e\xfd\xd1\xa2\a");
    self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
    self.point_center_anim = undefined;
    self.point_left_anim = undefined;
    self.point_right_anim = undefined;
    self.point_up_anim = undefined;
    self.point_down_anim = undefined;
    self.no_point_defined = 0;
    self._blackboard.point_gesture_active = 1;
    demeanor = asm::asm_getdemeanor();
    state = asm::asm_getcurrentstate(self.asmname);
    asm::asm_setupgesture(self.asmname, state);

    if(demeanor != "#yDV,\xd6" && demeanor != "4\xb1\xe7\xcd\xb6\xc0\xff\x9f\xd0\xf5") {
      self.gesture_point_parent = % b + M\\n\xdc\x8b\x96\\\xee\xffq0\x9d ^ u;
    } else {
      self.gesture_point_parent = % \x0e % \xc3\xad | \xc3d\x8a\x82 ? \xf3\xca\x85 + \xdc\xe1\"\xe9\xab\xc77;
    }

    if(!asm::asm_currentstatehasflag(self.asmname, "\xd7\xd8\xae\xb6\x0ea\xab")) {
      println("<dev string:x24>" + state + "<dev string:x34>");
      return;
    } else if(demeanor == "#yDV,\xd6" || demeanor == "\xe3\xd0\xc3e\x85h" || demeanor == "4\xb1\xe7\xcd\xb6\xc0\xff\x9f\xd0\xf5" || demeanor == "]\"\x81\x02y\xf7\xa4") {
      self.point_center_anim = self.asm.gestures.gesture_point_center;
      self.point_left_anim = self.asm.gestures.gesture_point_left;
      self.point_right_anim = self.asm.gestures.gesture_point_right;
      self.point_up_anim = self.asm.gestures.gesture_point_up;
      self.point_down_anim = self.asm.gestures.gesture_point_down;
      self.gesture_body_knob = asm::asm_getbodyknob();
    } else {
      println(demeanor + "<dev string:x52>");
      return;
    }

    if(isPlayer(pointat)) {
      lookat = level.player getEye();
    } else if(!isDefined(pointat)) {
      lookat = self.origin;
      self.no_point_defined = 1;
    } else if(isai(pointat)) {
      lookat = pointat getEye();
    } else if(isvector(pointat)) {
      lookat = pointat;
    } else {
      lookat = pointat.origin;
    }

    character_angles = self gettagangles("3'4\xc4\xf8l\x16\xdf") + (0, 90, 0);
    character_origin = self gettagorigin("3'4\xc4\xf8l\x16\xdf");
    var_2843579d190562dc = anglestoright(character_angles);
    var_ef102a45eb8603bf = anglestoup(character_angles);
    var_ccb85a7a69181c60 = vectorNormalize(lookat - character_origin);
    var_ead961cb15a65a08 = utility::flatten_vector(var_2843579d190562dc);
    var_38f46d7f8c947f3b = utility::flatten_vector(var_ef102a45eb8603bf);
    var_1db86a41098b2364 = utility::flatten_vector(var_ccb85a7a69181c60);
    dot_vec = vectordot(var_ead961cb15a65a08, var_1db86a41098b2364) * -1;
    var_ba898bb6ec8fffd5 = dot_vec * -1;
    clamped_dot = clamp(float_remap(dot_vec, 0.2, 1, 0, 1), 0, 1);
    var_fc50d69f9b16435 = clamp(float_remap(var_ba898bb6ec8fffd5, 0.2, 1, 0, 1), 0, 1);
    var_dbd5b9b1cfa1fd78 = self gettagorigin("3'4\xc4\xf8l\x16\xdf");
    var_99739f9fba96e136 = vectorNormalize(lookat - var_dbd5b9b1cfa1fd78);
    var_d00737f023dab81f = anglesToForward(character_angles);
    var_6fa1394cf916536c = vectordot(var_99739f9fba96e136, var_d00737f023dab81f);
    var_9729a7073b1dfe01 = var_6fa1394cf916536c * -1;
    var_ce6ae05d5683172a = vectordot(var_ef102a45eb8603bf, var_99739f9fba96e136);
    var_319698d5185d467c = clamp(float_remap(var_ce6ae05d5683172a, 0.2, 1, 0, 1), 0, 1);
    var_93b981311c756e02 = clamp(float_remap(var_6fa1394cf916536c, 0.2, 1, 0, 1), 0, 1);
    var_f3c5be2feff7dc1d = clamp(float_remap(var_9729a7073b1dfe01, 0.2, 1, 0, 1), 0, 1);

    if(!self.no_point_defined) {
      if(var_ce6ae05d5683172a < -0.9) {
        ai_gesture_simple("h\x93L\xe1l_\v\xe2n\x87\xf3");
      } else {
        if(demeanor != "#yDV,\xd6" && demeanor != "4\xb1\xe7\xcd\xb6\xc0\xff\x9f\xd0\xf5") {
          self setanimlimited(self.gesture_point_parent, 10, 0.25);
        } else {
          self setanimlimited(self.gesture_point_parent, 1, 0.25);
        }

        if(var_319698d5185d467c < 0.3) {
          self setanimlimited(self.point_center_anim, 0, 0, 0.85);
        } else {
          self setanimlimited(self.point_center_anim, var_319698d5185d467c, 0.25, 0.85);
        }

        if(isDefined(self.point_up_anim)) {
          self setanimlimited(self.point_up_anim, var_93b981311c756e02, 0.25, 0.85);
        }

        if(isDefined(self.point_down_anim)) {
          self setanimlimited(self.point_down_anim, var_f3c5be2feff7dc1d, 0.2, 0.85);
        }

        self setanimlimited(self.point_left_anim, var_fc50d69f9b16435, 0.25, 0.85);
        self setanimlimited(self.point_right_anim, clamped_dot, 0.25, 0.85);
      }
    } else {
      if(demeanor != "#yDV,\xd6" && demeanor != "4\xb1\xe7\xcd\xb6\xc0\xff\x9f\xd0\xf5") {
        self setanimlimited(self.gesture_point_parent, 10, 0.2);
      } else {
        self setanimlimited(self.gesture_point_parent, 1, 0.2);
      }

      self setanimlimited(self.point_center_anim, 1, 0.2, 0.85);
    }

    wait_time = getanimlength(%\xcc\xfbg\xa0\x89\x1e\xc4 * < ^ \xda < \xc1\x1b\x88\x1fY\xc8\xe3\n > \xe1\xfd\xd5\x11\xebpF\xbd) * 0.85;
    wait wait_time;
    self clearanim(self.gesture_point_parent, 0.25);
    self setanimlimited(self.gesture_body_knob, 1, 0.25);
    self._blackboard.point_gesture_active = 0;
  }

  function ai_gesture_simple(var_c69880d3de32c7a1) {
    self endon("\x1e\xfd\xd1\xa2\a");
    self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
    self.point_center_anim = undefined;
    self.gesture_body_knob = undefined;
    self.is_partial = 0;
    demeanor = "#yDV,\xd6";
    state = undefined;

    if(isai(self)) {
      self._blackboard.gesture_active = 1;
      demeanor = asm::asm_getdemeanor();
      state = asm::asm_getcurrentstate(self.asmname);
    }

    var_d1538a80ee5f3770 = ["\xf7{r\x90\x8b", "\x82\x90\xda{\x1e", "}\x9au", "4~\x99\x88\x19y", "\x9bJ\x13\xa9", "/\xc8,\r", "h\x93L\xe1l_\v\xe2n\x87\xf3"];
    var_7d0c86188444541a = [")?\x0f\xed\x9ct\xaa", "\xb77\xeb\xd6e", "\x11@2\x9a", "h\x93L\xe1l_\v\xe2n\x87\xf3", "fXc\x8d1a6\xb5\xf5#\xdb\xddn", "Y\xf6\xd0-\xf0\xa8"];
    var_7dd39dda1371b24 = [")?\x0f\xed\x9ct\xaa", "\xb77\xeb\xd6e", "\x11@2\x9a", "h\x93L\xe1l_\v\xe2n\x87\xf3", "fXc\x8d1a6\xb5\xf5#\xdb\xddn", "Y\xf6\xd0-\xf0\xa8"];
    var_d0f2c0b8a3cc4325 = ["\xf7{r\x90\x8b", "\x82\x90\xda{\x1e", "}\x9au", "4~\x99\x88\x19y", "\x9bJ\x13\xa9", "/\xc8,\r", ")?\x0f\xed\x9ct\xaa", "\xb77\xeb\xd6e", "\x11@2\x9a", "h\x93L\xe1l_\v\xe2n\x87\xf3", "fXc\x8d1a6\xb5\xf5#\xdb\xddn", "Y\xf6\xd0-\xf0\xa8"];

    if(!arraycontains(var_d1538a80ee5f3770, var_c69880d3de32c7a1) && !arraycontains(var_7d0c86188444541a, var_c69880d3de32c7a1)) {
      assert(var_c69880d3de32c7a1, "<dev string:x7a>");
      return;
    }

    if(!isDefined(self)) {
      return;
    }

    if(isai(self) && !asm::asm_currentstatehasflag(self.asmname, "\xd7\xd8\xae\xb6\x0ea\xab")) {
      println("<dev string:x24>" + state + "<dev string:x34>");
      return;
    } else if(isai(self)) {
      self.gesture_body_knob = asm::asm_getbodyknob();

      if(demeanor == "#yDV,\xd6") {
        if(arraycontains(var_d1538a80ee5f3770, var_c69880d3de32c7a1)) {
          self.gesture_shrug_anim = self.asm.gestures.gesture_shrug_anim;
          self.gesture_cross_anim = self.asm.gestures.gesture_cross_anim;
          self.gesture_nod_anim = self.asm.gestures.gesture_nod_anim;
          self.gesture_salute_anim = self.asm.gestures.gesture_salute_anim;
          self.gesture_wave_anim = self.asm.gestures.gesture_wave_anim;
          self.gesture_wait_anim = self.asm.gestures.gesture_wait_anim;
          self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
        } else {
          println("<dev string:xa8>");
          return;
        }
      } else if(demeanor == "4\xb1\xe7\xcd\xb6\xc0\xff\x9f\xd0\xf5") {
        if(arraycontains(var_d0f2c0b8a3cc4325, var_c69880d3de32c7a1)) {
          self.gesture_shrug_anim = self.asm.gestures.gesture_shrug_anim;
          self.gesture_cross_anim = self.asm.gestures.gesture_cross_anim;
          self.gesture_nod_anim = self.asm.gestures.gesture_nod_anim;
          self.gesture_salute_anim = self.asm.gestures.gesture_salute_anim;
          self.gesture_wave_anim = self.asm.gestures.gesture_wave_anim;
          self.gesture_wait_anim = self.asm.gestures.gesture_wait_anim;
          self.gesture_moveup_anim = self.asm.gestures.gesture_moveup_anim;
          self.gesture_onme_anim = self.asm.gestures.gesture_onme_anim;
          self.gesture_hold_anim = self.asm.gestures.gesture_hold_anim;
          self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
          self.gesture_fallback_down_anim = self.asm.gestures.gesture_fallback_down_anim;
          self.gesture_armup_anim = self.asm.gestures.gesture_armup_anim;
        } else {
          println("<dev string:xd5>");
          return;
        }
      } else if(demeanor == "\xe3\xd0\xc3e\x85h") {
        if(arraycontains(var_7d0c86188444541a, var_c69880d3de32c7a1)) {
          self.gesture_moveup_anim = self.asm.gestures.gesture_moveup_anim;
          self.gesture_onme_anim = self.asm.gestures.gesture_onme_anim;
          self.gesture_hold_anim = self.asm.gestures.gesture_hold_anim;
          self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
          self.gesture_fallback_down_anim = self.asm.gestures.gesture_fallback_down_anim;
          self.gesture_armup_anim = self.asm.gestures.gesture_armup_anim;
        } else {
          println("<dev string:x106>");
          return;
        }
      } else if(demeanor == "\x15'\xa3") {
        if(arraycontains(var_7dd39dda1371b24, var_c69880d3de32c7a1)) {
          self.gesture_moveup_anim = self.asm.gestures.gesture_moveup_anim;
          self.gesture_onme_anim = self.asm.gestures.gesture_onme_anim;
          self.gesture_hold_anim = self.asm.gestures.gesture_hold_anim;
          self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
          self.gesture_fallback_down_anim = self.asm.gestures.gesture_fallback_down_anim;
          self.gesture_armup_anim = self.asm.gestures.gesture_armup_anim;
        } else {
          println("<dev string:x133>");
          return;
        }
      } else if(demeanor == "]\"\x81\x02y\xf7\xa4") {
        if(arraycontains(var_7d0c86188444541a, var_c69880d3de32c7a1)) {
          self.gesture_moveup_anim = self.asm.gestures.gesture_moveup_anim;
          self.gesture_onme_anim = self.asm.gestures.gesture_onme_anim;
          self.gesture_hold_anim = self.asm.gestures.gesture_hold_anim;
          self.gesture_fallback_up_anim = self.asm.gestures.gesture_fallback_up_anim;
          self.gesture_fallback_down_anim = self.asm.gestures.gesture_fallback_down_anim;
          self.gesture_armup_anim = self.asm.gestures.gesture_armup_anim;
        } else {
          println("<dev string:x106>");
          return;
        }
      } else {
        println(demeanor + "<dev string:x52>");
        return;
      }
    } else {
      self.gesture_shrug_anim = % \n % \x92\x89\xdc\x89\xc4\xb5\x01\xcf\xfc\x1c =
    }\
    v\x81b\xc8\xaae\xa7\xce\xfa\xe0\xbf\x84;
    self.gesture_cross_anim = % `\x99\x1dp\x13u\xdba\a\v\xbdL\x1d\x99\xa6[\f\xc3\xb8\xa7` / J\x99\xf3\xad;
    self.gesture_nod_anim = % \x7fP\x8c\x16\n\x10QV$\x88\xce\x0em\x85\x9d\xbfQ\f_\xaa\x19\x84U2;
    self.gesture_salute_anim = % s\x1aK\x0e\xb1r\x961\xf5;\
    xdc\x1d_\x1ae\x16F_\xb9\xb06\xab\x1d\xca\xfa\x18\xc4;
    self.gesture_wave_anim = % \xbe\b\x84\f\x96\xb2xnE\xf0\xdf\xc7\xfd\x1f, i\xe1\x80\xc7\x05\x9a\x0e\xe1\xe9, ;
    self.gesture_wait_anim = % , A\xcf\x9b\x99\xc6i\b\x18\xd6\x13K\x88x\xa3 % I\x9f\xafoUV\x11m\x9c;
    self.gesture_fallback_up_anim = % \xa9\x15\xa1HV\xd3\"\xb6\xb8k\xdf\x98\x10Gc\xe9O\x86\x96\xd8\x91\x1bj\t \xc1\xcf\xc7;
  }

  var_a6fd9f89f6fcbd8e = undefined;

  switch (var_c69880d3de32c7a1) {
    case #"hash_f95a6a3ee8c001ec":
      var_a6fd9f89f6fcbd8e = self.gesture_shrug_anim;
      break;
    case #"hash_eb00cb01bd7a6e7b":
      var_a6fd9f89f6fcbd8e = self.gesture_cross_anim;
      break;
    case #"hash_40a1376c2c1dba9a":
      var_a6fd9f89f6fcbd8e = self.gesture_nod_anim;
      break;
    case #"hash_c7d247b0c27f20b1":
      var_a6fd9f89f6fcbd8e = self.gesture_salute_anim;
      break;
    case #"hash_bda5687440fc2934":
      var_a6fd9f89f6fcbd8e = self.gesture_wave_anim;
      break;
    case #"hash_bdf347744138cb00":
      var_a6fd9f89f6fcbd8e = self.gesture_wait_anim;
      break;
    case #"hash_dd93195493d0c818":
      self.is_partial = 1;
      var_a6fd9f89f6fcbd8e = self.gesture_hold_anim;
      break;
    case #"hash_b8e7e4b53801f40f":
      self.is_partial = 1;
      var_a6fd9f89f6fcbd8e = self.gesture_onme_anim;
      break;
    case #"hash_c49910ada754deb4":
      self.is_partial = 1;
      var_a6fd9f89f6fcbd8e = self.gesture_moveup_anim;
      break;
    case #"hash_486396f4d5e0cc51":
      self.is_partial = 1;
      var_a6fd9f89f6fcbd8e = self.gesture_fallback_up_anim;
      break;
    case #"hash_f61262b439059658":
      self.is_partial = 1;
      var_a6fd9f89f6fcbd8e = self.gesture_fallback_down_anim;
      break;
    case #"hash_de706ce2cae61473":
      self.is_partial = 1;
      var_a6fd9f89f6fcbd8e = self.gesture_armup_anim;
      break;
  }

  if(self.is_partial) {
    self.simple_gesture_parent = % b + M\\n\xdc\x8b\x96\\\xee\xffq0\x9d ^ u;
  } else {
    self.simple_gesture_parent = % \xa8C\x14\x84) s\xdc\xbe\x9a[\xf6;
  }

  if(self.is_partial) {
    thread blend_partial_in(self.simple_gesture_parent, var_a6fd9f89f6fcbd8e, 0.5);
  } else {
    self setanimlimited(self.simple_gesture_parent, 1, 0.5);
    self setanimlimited(var_a6fd9f89f6fcbd8e, 1, 0.5, 0.75);
  }

  wait_time = getanimlength(var_a6fd9f89f6fcbd8e) * 0.85;
  wait wait_time;

  if(self.is_partial) {
    thread blend_partial_out(self.simple_gesture_parent, var_a6fd9f89f6fcbd8e, 0.5);
  } else {
    self clearanim(self.simple_gesture_parent, 0.5);
    self clearanim(var_a6fd9f89f6fcbd8e, 0.5);
  }

  self.is_partial = 0;

  if(isai(self)) {
    self._blackboard.gesture_active = undefined;
  }
}

function blend_partial_in(gesture_parent, animation, blend_time, notetrack) {
  blend = blend_time * 0.5;
  self setanimlimited(gesture_parent, 1, blend);
  self setanimlimited(animation, 1, blend, 0.75);
  wait blend_time * 0.5;
  self setanimlimited(animation, 10, blend, 0.75);
  self setanimlimited(gesture_parent, 10, blend);
}

function blend_partial_out(gesture_parent, animation, clear_time) {
  clear = clear_time * 0.5;
  self setanimlimited(gesture_parent, 1, clear);
  self setanimlimited(animation, 1, clear);
  wait clear;
  self clearanim(gesture_parent, clear);
  self clearanim(animation, clear);
}

function float_remap(value, from1, to1, from2, to2) {
  return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
}

function lerp_float(from, to, delta) {
  return from + delta * (to - from);
}

function smoothstep(start, end, delta) {
  delta = clamp((delta - start) / (end - start), 0, 1);
  return delta * delta * (3 - 2 * delta);
}

function set_time_via_rate(anime, time, weight, blend_time) {
  if(!isDefined(weight)) {
    weight = 1;
  }

  if(!isDefined(blend_time)) {
    blend_time = 0.25;
  }

  prev_time = self getanimtime(anime);
  duration = getanimlength(anime);
  rate = (time - prev_time) * duration / 0.05;
  self setanimlimited(anime, weight, blend_time, rate);
}

function ai_gesture_directional_custom(target, anim_array, partial_bool) {
  self endon("oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  anims = anim_array;
  var_40e8dad336fafa59 = anim_array[0];
  var_7cee09010a8831ed = anim_array[1];
  var_7b6e373b8161a9da = anim_array[2];
  var_64e327152e95dc59 = anim_array[3];
  var_65d0b26d7a3a5cf2 = anim_array[4];
  var_23668f8bdbdfb4f1 = 0;
  gesture_body_knob = undefined;
  self.no_point_defined = 0;
  gesture_parent = undefined;

  if(isDefined(partial_bool)) {
    gesture_body_knob = asm::asm_getbodyknob();
    gesture_parent = % b + M\\n\xdc\x8b\x96\\\xee\xffq0\x9d ^ u;
  } else {
    gesture_parent = % \xa8C\x14\x84) s\xdc\xbe\x9a[\xf6;
  }

  if(!isDefined(self)) {
    return;
  }

  if(isPlayer(target)) {
    lookat = level.player getEye();
  } else if(!isDefined(target)) {
    lookat = self.origin;
    var_23668f8bdbdfb4f1 = 1;
  } else if(isai(target)) {
    lookat = target getEye();
  } else if(isvector(target)) {
    lookat = target;
  } else {
    lookat = target.origin;
  }

  character_angles = self gettagangles("\xec\xbfK|\au\xcd\xc2\x19<");
  character_origin = self gettagorigin("\xec\xbfK|\au\xcd\xc2\x19<");
  var_2843579d190562dc = anglestoright(character_angles);
  var_ef102a45eb8603bf = anglesToForward(character_angles);
  var_ccb85a7a69181c60 = vectorNormalize(lookat - character_origin);
  var_ead961cb15a65a08 = utility::flatten_vector(var_2843579d190562dc);
  var_38f46d7f8c947f3b = utility::flatten_vector(var_ef102a45eb8603bf);
  var_1db86a41098b2364 = utility::flatten_vector(var_ccb85a7a69181c60);
  dot_vec = vectordot(var_ead961cb15a65a08, var_1db86a41098b2364);
  var_ba898bb6ec8fffd5 = dot_vec * -1;
  clamped_dot = clamp(float_remap(dot_vec, 0.2, 1, 0, 1), 0, 1);
  var_fc50d69f9b16435 = clamp(float_remap(var_ba898bb6ec8fffd5, 0.2, 1, 0, 1), 0, 1);
  var_dbd5b9b1cfa1fd78 = self gettagorigin("3'4\xc4\xf8l\x16\xdf");
  var_99739f9fba96e136 = vectorNormalize(lookat - var_dbd5b9b1cfa1fd78);
  var_d00737f023dab81f = anglestoup(character_angles);
  var_6fa1394cf916536c = vectordot(var_99739f9fba96e136, var_d00737f023dab81f);
  var_9729a7073b1dfe01 = var_6fa1394cf916536c * -1;
  var_ce6ae05d5683172a = vectordot(var_38f46d7f8c947f3b, var_99739f9fba96e136);
  var_319698d5185d467c = clamp(float_remap(var_ce6ae05d5683172a, 0.2, 1, 0, 1), 0, 1);
  var_93b981311c756e02 = clamp(float_remap(var_6fa1394cf916536c, 0.2, 1, 0, 1), 0, 1);
  var_f3c5be2feff7dc1d = clamp(float_remap(var_9729a7073b1dfe01, 0.2, 1, 0, 1), 0, 1);

  if(!self.no_point_defined) {
    if(isDefined(partial_bool)) {
      self setanimlimited(gesture_parent, 10, 0.25);
    } else {
      self setanimlimited(gesture_parent, 1, 0.25);
    }

    if(var_319698d5185d467c < 0.3) {
      self setanimlimited(var_40e8dad336fafa59, 0, 0, 1);
    } else {
      self setanimlimited(var_40e8dad336fafa59, var_319698d5185d467c, 0.25, 1);
    }

    if(isDefined(var_64e327152e95dc59)) {
      self setanimlimited(var_64e327152e95dc59, var_93b981311c756e02, 0.25, 1);
    }

    if(isDefined(var_65d0b26d7a3a5cf2)) {
      self setanimlimited(var_65d0b26d7a3a5cf2, var_f3c5be2feff7dc1d, 0.25, 1);
    }

    self setanimlimited(var_7cee09010a8831ed, var_fc50d69f9b16435, 0.25, 1);
    self setanimlimited(var_7b6e373b8161a9da, clamped_dot, 0.25, 1);
  } else {
    if(isDefined(partial_bool)) {
      self setanimlimited(gesture_body_knob, 0.001, 0.1);
    }

    self setanimlimited(gesture_parent, 1, 0.25);
    self setanimlimited(var_40e8dad336fafa59, 1, 0.25);
  }

  wait_time = getanimlength(var_40e8dad336fafa59);
  wait wait_time;
  self clearanim(gesture_parent, 0.25);
  self setanimlimited(gesture_body_knob, 1, 0.25);
}

function ai_custom_gesture(gesture_anim, partial_bool) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  gesture_root = % \xa8C\x14\x84) s\xdc\xbe\x9a[\xf6; using_partial = 0; notification = "\xb3\\\x97b@19[\x9e\xc1\xd7"; thread notetrack::start_notetrack_wait(self, notification, undefined, undefined, gesture_anim);

  if(isDefined(partial_bool) && partial_bool) {
    gesture_root = % b + M\\n\xdc\x8b\x96\\\xee\xffq0\x9d ^ u;
    using_partial = 1;
  }

  if(using_partial) {
    thread blend_partial_in(gesture_root, gesture_anim, 0.2);
  } else {
    self setanimlimited(gesture_root, 1, 0.1);
    self setanimlimited(gesture_anim, 1, 0.1);
  }

  wait_time = getanimlength(gesture_anim) * 0.75 - 0.2; wait wait_time;

  if(using_partial) {
    thread blend_partial_out(gesture_root, gesture_anim, 0.2);
    return;
  }

  self clearanim(gesture_root, 0.2); self clearanim(gesture_anim, 0.2);
}

function blended_loop_anim() {
  guy = self;
  self endon(self.ender);
  guy.fwd_anim = undefined;
  guy.right_anim = undefined;
  guy.left_anim = undefined;
  guy.leftback_anim = undefined;
  guy.rightback_anim = undefined;

  foreach(thing in guy.anim_array) {
    if(issubstr(thing, "\xa17\xd3\x9fT\x14P")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.fwd_anim = level.scr_anim[guy.animname][thing];
      }

      continue;
    }

    if(issubstr(thing, "o0\xee\xc1\x8c") && !issubstr(thing, "\x8a+\xf04")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.right_anim = level.scr_anim[guy.animname][thing];
      }

      continue;
    }

    if(issubstr(thing, "=\xff0b") && !issubstr(thing, "\x8a+\xf04")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.left_anim = level.scr_anim[guy.animname][thing];
      }

      continue;
    }

    if(issubstr(thing, "_\xef\xa0\xb5\x8c\xba\f\xa5")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.leftback_anim = level.scr_anim[guy.animname][thing];
      }

      continue;
    }

    if(issubstr(thing, "\x17<\xff\xbb\xa0\x91fIf")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.rightback_anim = level.scr_anim[guy.animname][thing];
      }
    }
  }

  org = getstartorigin(self.animnode.origin, self.animnode.angles, guy.fwd_anim);
  ang = getstartangles(self.animnode.origin, self.animnode.angles, guy.fwd_anim);

  if(isai(guy)) {
    guy forceteleport(org, ang, 10000);
  } else {
    guy.origin = org;
    guy.angles = ang;
  }

  var_3a0109b661e8a1a7 = vectortoangles(level.player.origin - guy.origin);
  guy setanimknoball(guy.fwd_anim, %\x11\x9ag\xc4, 1, 0.2);

  if(isDefined(guy.right_anim)) {
    guy setanimlimited(guy.right_anim, 0, 0.2);
  }

  if(isDefined(guy.left_anim)) {
    guy setanimlimited(guy.left_anim, 0, 0.2);
  }

  if(isDefined(guy.leftback_anim)) {
    guy setanimlimited(guy.leftback_anim, 0, 0.2);
  }

  if(isDefined(guy.rightback_anim)) {
    guy setanimlimited(guy.rightback_anim, 0, 0.2);
  }

  var_e6b8d311282ec15d = 0;
  var_17fe93aa2ce8e05a = 0;
  guy pushplayer(1);

  while(true) {
    if(!isDefined(guy)) {
      break;
    }

    if(isPlayer(guy.gesture_lookat)) {
      lookat = level.player getEye();
    } else if(isai(guy.gesture_lookat)) {
      lookat = guy.gesture_lookat getEye();
    } else if(isvector(guy.gesture_lookat)) {
      lookat = guy.gesture_lookat;
    } else {
      lookat = guy.gesture_lookat.origin;
    }

    var_eff4a8961c1e0c3b = guy gettagangles("\xec\xbfK|\au\xcd\xc2\x19<");
    var_22ee72ef79fe89b = guy gettagorigin("\xec\xbfK|\au\xcd\xc2\x19<");
    vec_to_player = utility::flatten_vector(vectorNormalize(lookat - var_22ee72ef79fe89b));
    forward_vec = anglesToForward(var_eff4a8961c1e0c3b);
    right_vec = anglestoright(var_eff4a8961c1e0c3b);
    left_vec = anglestoright(var_eff4a8961c1e0c3b) * -1;
    back_vec = anglesToForward(var_eff4a8961c1e0c3b) * -1;
    up_vec = anglestoup(var_eff4a8961c1e0c3b);
    dot_fwd = clamp(vectordot(vec_to_player, forward_vec), 0, 1);
    dot_right = clamp(vectordot(vec_to_player, right_vec), 0, 1);
    dot_left = clamp(vectordot(vec_to_player, left_vec), 0, 1);
    dot_back = clamp(vectordot(vec_to_player, back_vec), 0, 1);
    back_test = 1;

    if(math::anglebetweenvectorssigned(forward_vec, vec_to_player, up_vec) > 0) {
      back_test = 0;
    }

    if(isDefined(guy.right_anim)) {
      guy setanimlimited(guy.right_anim, dot_right, 0.2);
    }

    if(isDefined(guy.left_anim)) {
      guy setanimlimited(guy.left_anim, dot_left, 0.2);
    }

    guy setanimlimited(guy.fwd_anim, dot_fwd + 0.005, 0.2);

    if(back_test) {
      var_e6b8d311282ec15d = math::lerp(var_e6b8d311282ec15d, dot_back, 0.1);
      var_17fe93aa2ce8e05a = math::lerp(var_17fe93aa2ce8e05a, 0, 0.1);
    } else {
      var_e6b8d311282ec15d = math::lerp(var_e6b8d311282ec15d, 0, 0.1);
      var_17fe93aa2ce8e05a = math::lerp(var_17fe93aa2ce8e05a, dot_back, 0.1);
    }

    if(isDefined(guy.rightback_anim)) {
      guy setanimlimited(guy.rightback_anim, var_e6b8d311282ec15d + 0.005, 0.2);
    }

    if(isDefined(guy.leftback_anim)) {
      guy setanimlimited(guy.leftback_anim, var_17fe93aa2ce8e05a + 0.005, 0.2);
    }

    waitframe();
    waittillframeend();
  }
}

function blended_loop_cleanup() {
  guy = self;

  if(isDefined(guy.ender)) {
    guy notify(guy.ender);
  }

  guy clearanim(guy.fwd_anim, 0.2);

  if(isDefined(guy.right_anim)) {
    guy clearanim(guy.right_anim, 0.2);
  }

  if(isDefined(guy.left_anim)) {
    guy clearanim(guy.left_anim, 0.2);
  }

  if(isDefined(guy.leftback_anim)) {
    guy clearanim(guy.leftback_anim, 0.2);
  }

  if(isDefined(guy.rightback_anim)) {
    guy clearanim(guy.rightback_anim, 0.2);
  }

  guy pushplayer(0);
  guy.fwd_anim = undefined;
  guy.right_anim = undefined;
  guy.left_anim = undefined;
  guy.leftback_anim = undefined;
  guy.rightback_anim = undefined;
  guy.anim_array = undefined;
  guy.ender = undefined;
  guy.gesture_lookat = undefined;
}

function blended_anim() {
  guy = self;
  guy.fwd_anim = undefined;
  guy.right_anim = undefined;
  guy.left_anim = undefined;
  guy.leftback_anim = undefined;
  guy.rightback_anim = undefined;

  foreach(thing in guy.anim_array) {
    if(issubstr(thing, "\xa17\xd3\x9fT\x14P")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.fwd_anim = level.scr_anim[guy.animname][thing];
      }

      continue;
    }

    if(issubstr(thing, "o0\xee\xc1\x8c") && !issubstr(thing, "\x8a+\xf04")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.right_anim = level.scr_anim[guy.animname][thing];
      }

      continue;
    }

    if(issubstr(thing, "=\xff0b") && !issubstr(thing, "\x8a+\xf04")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.left_anim = level.scr_anim[guy.animname][thing];
      }

      continue;
    }

    if(issubstr(thing, "_\xef\xa0\xb5\x8c\xba\f\xa5")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.leftback_anim = level.scr_anim[guy.animname][thing];
      }

      continue;
    }

    if(issubstr(thing, "\x17<\xff\xbb\xa0\x91fIf")) {
      if(isDefined(level.scr_anim[guy.animname][thing])) {
        guy.rightback_anim = level.scr_anim[guy.animname][thing];
      }
    }
  }

  org = getstartorigin(self.animnode.origin, self.animnode.angles, guy.fwd_anim);
  ang = getstartangles(self.animnode.origin, self.animnode.angles, guy.fwd_anim);

  if(isai(guy)) {
    guy forceteleport(org, ang, 10000);
  } else {
    guy.origin = org;
    guy.angles = ang;
  }

  var_3a0109b661e8a1a7 = vectortoangles(level.player.origin - guy.origin);
  guy setanimknoball(guy.fwd_anim, %\x11\x9ag\xc4, 1, 0.2);

  if(isDefined(guy.right_anim)) {
    guy setanimlimited(guy.right_anim, 0, 0.2);
  }

  if(isDefined(guy.left_anim)) {
    guy setanimlimited(guy.left_anim, 0, 0.2);
  }

  if(isDefined(guy.leftback_anim)) {
    guy setanimlimited(guy.leftback_anim, 0, 0.2);
  }

  if(isDefined(guy.rightback_anim)) {
    guy setanimlimited(guy.rightback_anim, 0, 0.2);
  }

  var_e6b8d311282ec15d = 0;
  var_17fe93aa2ce8e05a = 0;
  start_time = gettime() / 1000;
  wait_time = getanimlength(guy.fwd_anim);

  while(gettime() / 1000 - start_time < wait_time) {
    if(!isDefined(guy)) {
      break;
    }

    if(isPlayer(guy.gesture_lookat)) {
      lookat = level.player getEye();
    } else if(isai(guy.gesture_lookat)) {
      lookat = guy.gesture_lookat getEye();
    } else if(isvector(guy.gesture_lookat)) {
      lookat = guy.gesture_lookat;
    } else {
      lookat = guy.gesture_lookat.origin;
    }

    var_eff4a8961c1e0c3b = guy gettagangles("\xec\xbfK|\au\xcd\xc2\x19<");
    var_22ee72ef79fe89b = guy gettagorigin("\xec\xbfK|\au\xcd\xc2\x19<");
    vec_to_player = utility::flatten_vector(vectorNormalize(lookat - var_22ee72ef79fe89b));
    forward_vec = anglesToForward(var_eff4a8961c1e0c3b);
    right_vec = anglestoright(var_eff4a8961c1e0c3b);
    left_vec = anglestoright(var_eff4a8961c1e0c3b) * -1;
    back_vec = anglesToForward(var_eff4a8961c1e0c3b) * -1;
    up_vec = anglestoup(var_eff4a8961c1e0c3b);
    dot_fwd = clamp(vectordot(vec_to_player, forward_vec), 0, 1);
    dot_right = clamp(vectordot(vec_to_player, right_vec), 0, 1);
    dot_left = clamp(vectordot(vec_to_player, left_vec), 0, 1);
    dot_back = clamp(vectordot(vec_to_player, back_vec), 0, 1);
    back_test = 1;

    if(math::anglebetweenvectorssigned(forward_vec, vec_to_player, up_vec) > 0) {
      back_test = 0;
    }

    if(isDefined(guy.right_anim)) {
      guy setanimlimited(guy.right_anim, dot_right, 0.2);
    }

    if(isDefined(guy.left_anim)) {
      guy setanimlimited(guy.left_anim, dot_left, 0.2);
    }

    guy setanimlimited(guy.fwd_anim, dot_fwd + 0.005, 0.2);

    if(back_test) {
      var_e6b8d311282ec15d = math::lerp(var_e6b8d311282ec15d, dot_back, 0.1);
      var_17fe93aa2ce8e05a = math::lerp(var_17fe93aa2ce8e05a, 0, 0.1);
    } else {
      var_e6b8d311282ec15d = math::lerp(var_e6b8d311282ec15d, 0, 0.1);
      var_17fe93aa2ce8e05a = math::lerp(var_17fe93aa2ce8e05a, dot_back, 0.1);
    }

    if(isDefined(guy.rightback_anim)) {
      guy setanimlimited(guy.rightback_anim, var_e6b8d311282ec15d + 0.005, 0.2);
    }

    if(isDefined(guy.leftback_anim)) {
      guy setanimlimited(guy.leftback_anim, var_17fe93aa2ce8e05a + 0.005, 0.2);
    }

    waitframe();
    waittillframeend();
  }

  guy thread blended_loop_cleanup();
}