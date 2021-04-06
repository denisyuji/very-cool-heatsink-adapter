heatsink_holder ();

include<roundedcube.scad>

module heatsink_holder ()
{
	// Editable parameters 
	thickness = 1;
	hole_distance_width_front = 79.2;
	hole_distance_width_rear = 65.2;
	hole_distance_lenght = 25.9;

	som_thickness=1.2;
	soc_thickness=1.481;
	thermal_pad_thickness=1.2;
	spacer_hole_diameter = 2.2;

	heatsink_width = 51+0.4;
	heatsink_lenght = 25+0.4;
	heatsink_height = 12;
	heatsink_fan_diameter = 24;
	heatsink_fan_offset = 13;
	heatsink_screw_diameter = 3.2;
	heatsink_screw_x_pos = heatsink_fan_offset+10;
	heatsink_screw_y_pos = 10;

	// Auxiliary variables
	spacer_height_front = thermal_pad_thickness+soc_thickness+som_thickness;
	spacer_height_rear =  thermal_pad_thickness+soc_thickness;
	spacer_diameter = spacer_hole_diameter + thickness * 2;
	spacer_radius = spacer_diameter/2;
	max_width = hole_distance_width_front + spacer_diameter;
	max_lenght = hole_distance_lenght + spacer_diameter;

	// Shape

	difference(){
		union(){

			// main panel
			difference(){
				translate ([-max_width/2,-max_lenght/2,0]){
					cube([  max_width,max_lenght,thickness]);}
				// Front Rear difference removal
				translate ([max_width/2-(hole_distance_width_front-hole_distance_width_rear)/2,-max_lenght/2+spacer_diameter,0]){
					cube([(hole_distance_width_front-hole_distance_width_rear)/2,max_lenght-spacer_diameter,thickness]);}
				translate ([-(max_width/2),-max_lenght/2+spacer_diameter,0]){
					cube([(hole_distance_width_front-hole_distance_width_rear)/2,max_lenght-spacer_diameter,thickness]);}
				// Space for round corners
				translate ([hole_distance_width_rear/2, hole_distance_lenght/2, 0]){
					cube([spacer_radius, spacer_radius,thickness]);}
				translate ([-(hole_distance_width_rear/2)-spacer_radius, hole_distance_lenght/2, 0]){
					cube([spacer_radius, spacer_radius,thickness]);}

				translate ([hole_distance_width_front/2, -hole_distance_lenght/2-spacer_radius, 0]){
				  cube([spacer_radius, spacer_diameter,thickness]);}
				translate ([-(hole_distance_width_front/2)-spacer_radius, -hole_distance_lenght/2-spacer_radius, 0]){
				  cube([spacer_radius, spacer_diameter,thickness]);}
			}
				
			// Spacers
			translate ([hole_distance_width_rear/2, hole_distance_lenght/2, -spacer_height_rear]){
				cylinder(h = spacer_height_rear + thickness, r = spacer_radius);
			}
			translate ([-hole_distance_width_rear/2, hole_distance_lenght/2, -spacer_height_rear]){
				cylinder(h = spacer_height_rear + thickness, r = spacer_radius);
			}
			translate ([-hole_distance_width_front/2, -hole_distance_lenght/2, -spacer_height_front]){
				cylinder(h = spacer_height_front + thickness, r = spacer_radius);
			}
			translate ([hole_distance_width_front/2, -hole_distance_lenght/2, -spacer_height_front]){
				cylinder(h = spacer_height_front + thickness, r = spacer_radius);
			}
			// heatsink housing
			translate ([0,0,(heatsink_height+thickness)/2]){
				roundedcube([heatsink_width+(thickness*2),heatsink_lenght+(thickness*2),heatsink_height+thickness], true, thickness/2, "zmax");
			}
		}
		// heatsink housing cavity
		translate ([-(heatsink_width/2),-(heatsink_lenght/2),0]){
			cube([heatsink_width,heatsink_lenght,heatsink_height]);
		}
		// Spacers holes
		translate ([hole_distance_width_rear/2,  hole_distance_lenght/2, -spacer_height_rear]){
			cylinder(h = spacer_height_rear + thickness, r = spacer_hole_diameter/2);
		}
		translate ([-hole_distance_width_rear/2, hole_distance_lenght/2, -spacer_height_rear]){
			cylinder(h = spacer_height_rear + thickness, r = spacer_hole_diameter/2);
		}
		translate ([-hole_distance_width_front/2,-hole_distance_lenght/2,-spacer_height_front]){
			cylinder(h = spacer_height_front + thickness, r = spacer_hole_diameter/2);
		}
		translate ([hole_distance_width_front/2, -hole_distance_lenght/2,-spacer_height_front]){
			cylinder(h = spacer_height_front + thickness, r = spacer_hole_diameter/2);
		}
			
		// Heatsink screw holes
		translate ([heatsink_screw_x_pos,heatsink_screw_y_pos,heatsink_height]){
			cylinder(h = thickness, r = heatsink_screw_diameter/2);}
		translate ([-heatsink_screw_x_pos,heatsink_screw_y_pos,heatsink_height]){
			cylinder(h = thickness, r = heatsink_screw_diameter/2);}
		translate ([heatsink_screw_x_pos,-heatsink_screw_y_pos,heatsink_height]){
			cylinder(h = thickness, r = heatsink_screw_diameter/2);}
		translate ([-heatsink_screw_x_pos,-heatsink_screw_y_pos,heatsink_height]){
			cylinder(h = thickness, r = heatsink_screw_diameter/2);}


		// Air flow cavity on lid
		translate ([heatsink_fan_offset,0,heatsink_height]){
			cylinder(h = thickness, r = heatsink_fan_diameter/2);}
		
		translate ([-heatsink_fan_offset,0,heatsink_height]){
			cylinder(h = thickness, r = heatsink_fan_diameter/2);}

		translate ([0,0,heatsink_height+thickness/2]){
			cube([heatsink_fan_offset*2,heatsink_fan_diameter,thickness],center=true);}

	}
}