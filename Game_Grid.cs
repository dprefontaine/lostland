using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using UnityEngine;


public class Game_Grid : MonoBehaviour {
    //VARIABLES
    //
    int x_size = 0,
        y_size = 0;
    public Square[][] grid_squares;
    //Normally most scripts shouldn't really care about this, as the rest is checked through grid squares, but just in case reference is needed
    //
    Vector4[] home = new Vector4[1],
              vanguard = new Vector4[1],
              neutral = new Vector4[1],
              player_area_1 = new Vector4[1],
              player_area_2 = new Vector4[1];

    Vector2Int[] wells = new Vector2Int[1],
                 summons = new Vector2Int[1];

    Vector2Int player_base_1 = new Vector2Int(),
               player_base_2 = new Vector2Int();

    //Use this for initialization
    //
    void Start () {
		
	}
	//TERRAIN LOADER AND UNLOADER
    //
    public void reading_terrain(string terrain_file_name) {
        //Patterns to catch
        //
        string comment_pattern = "^\b---\b$";
        string single_pattern = "^\\[d{2}]$";
        string box_pattern = "^[\\d{2},\\d{2},\\d{2},\\d{2}]$";
        string square_pattern = "^[\\d{2},\\d{2}]$";

        string[] lines = File.ReadAllLines(terrain_file_name, Encoding.UTF8);
        int counter = 0;

        //Ewwwwww look at this deep nest
        //Cut down on this code's complexity later, if possible (11/5/18)
        //
        for (int i = 0; i < lines.Length; i++) {
            //Making sure the line is not a comment
            
            MatchCollection t_matches = Regex.Matches(lines[i], comment_pattern);

            if (!(t_matches[0].Success)) {
                t_matches = Regex.Matches(lines[i], box_pattern);
                //Try a box pattern
                
                if (t_matches[0].Success) {
                    //Scoop data into terrain data

                    adding_terrain_data(counter, t_matches);
                    counter++;
                } else {
                    //Try a one-square pattern instead

                    t_matches = Regex.Matches(lines[i], square_pattern);

                    if (t_matches[0].Success) {

                        adding_terrain_data(counter, t_matches);
                        counter++;
                    }
                    else {
                        //Try a single number pattern instead

                        t_matches = Regex.Matches(lines[i], single_pattern);

                        if (t_matches[0].Success) {

                            adding_terrain_data(counter, t_matches);
                            counter++;
                        }
                    }
                }
            }
        }

        try {
            loading_terrain();
        } catch { }
    }

    void adding_terrain_data(int counter, MatchCollection matches) {
        int reference = 0, i = 0;
        float second_reference = 0f;

        switch (counter) {
            //Dimension x
            case 1:
                int.TryParse(matches[0].Captures[0].Value, out reference);
                x_size = reference;
                break;
            //Dimension y
            case 2:
                int.TryParse(matches[0].Captures[0].Value, out reference);
                y_size = reference;
                break;
            //Home
            case 3:
                home = new Vector4[matches.Count];

                foreach (Match t_match in matches) {
                    home[i] = new Vector4();

                    float.TryParse(t_match.Captures[0].Value, out second_reference);
                    home[i].w = second_reference;
                    float.TryParse(t_match.Captures[1].Value, out second_reference);
                    home[i].x = second_reference;
                    float.TryParse(t_match.Captures[2].Value, out second_reference);
                    home[i].y = second_reference;
                    float.TryParse(t_match.Captures[3].Value, out second_reference);
                    home[i].z = second_reference;
                    i++;
                }
                break;
            //Vanguard
            case 4:
                vanguard = new Vector4[matches.Count];

                foreach (Match t_match in matches) {
                    vanguard[i] = new Vector4();

                    float.TryParse(t_match.Captures[0].Value, out second_reference);
                    vanguard[i].w = second_reference;
                    float.TryParse(t_match.Captures[1].Value, out second_reference);
                    vanguard[i].x = second_reference;
                    float.TryParse(t_match.Captures[2].Value, out second_reference);
                    vanguard[i].y = second_reference;
                    float.TryParse(t_match.Captures[3].Value, out second_reference);
                    vanguard[i].z = second_reference;
                    i++;
                }
                break;
            //Neutral
            case 5:
                neutral = new Vector4[matches.Count];

                foreach (Match t_match in matches) {
                    neutral[i] = new Vector4();

                    float.TryParse(t_match.Captures[0].Value, out second_reference);
                    neutral[i].w = second_reference;
                    float.TryParse(t_match.Captures[1].Value, out second_reference);
                    neutral[i].x = second_reference;
                    float.TryParse(t_match.Captures[2].Value, out second_reference);
                    neutral[i].y = second_reference;
                    float.TryParse(t_match.Captures[3].Value, out second_reference);
                    neutral[i].z = second_reference;
                    i++;
                }
                break;
            //Wells
            case 6:
                wells = new Vector2Int[matches.Count];

                foreach (Match t_match in matches) {
                    wells[i] = new Vector2Int();

                    int.TryParse(t_match.Captures[0].Value, out reference);
                    wells[i].x = reference;
                    int.TryParse(t_match.Captures[1].Value, out reference);
                    wells[i].y = reference;
                    i++;
                }
                break;
            //Summoning
            case 7:
                summons = new Vector2Int[matches.Count];

                foreach (Match t_match in matches) {
                    summons[i] = new Vector2Int();

                    int.TryParse(t_match.Captures[0].Value, out reference);
                    summons[i].x = reference;
                    int.TryParse(t_match.Captures[1].Value, out reference);
                    summons[i].y = reference;
                    i++;
                }
                break;
            //Player Base One
            case 8:
                player_base_1 = new Vector2Int();

                int.TryParse(matches[0].Captures[0].Value, out reference);
                player_base_1.x = reference;
                int.TryParse(matches[0].Captures[1].Value, out reference);
                player_base_1.y = reference;
                break;
            //Player Base Two
            case 9:
                player_base_2 = new Vector2Int();

                int.TryParse(matches[0].Captures[0].Value, out reference);
                player_base_2.x = reference;
                int.TryParse(matches[0].Captures[1].Value, out reference);
                player_base_2.y = reference;
                break;
            //Player Side One
            case 10:
                player_area_1 = new Vector4[matches.Count];

                foreach (Match t_match in matches) {
                    player_area_1[i] = new Vector4();

                    float.TryParse(t_match.Captures[0].Value, out second_reference);
                    player_area_1[i].w = second_reference;
                    float.TryParse(t_match.Captures[1].Value, out second_reference);
                    player_area_1[i].x = second_reference;
                    float.TryParse(t_match.Captures[2].Value, out second_reference);
                    player_area_1[i].y = second_reference;
                    float.TryParse(t_match.Captures[3].Value, out second_reference);
                    player_area_1[i].z = second_reference;
                    i++;
                }
                break;
            //Player Side Two
            case 11:
                player_area_2 = new Vector4[matches.Count];
                
                foreach (Match t_match in matches) {
                    player_area_2[i] = new Vector4();

                    float.TryParse(t_match.Captures[0].Value, out second_reference);
                    player_area_2[i].w = second_reference;
                    float.TryParse(t_match.Captures[1].Value, out second_reference);
                    player_area_2[i].x = second_reference;
                    float.TryParse(t_match.Captures[2].Value, out second_reference);
                    player_area_2[i].y = second_reference;
                    float.TryParse(t_match.Captures[3].Value, out second_reference);
                    player_area_2[i].z = second_reference;
                    i++;
                }
                break;
        }

    }

    int[] bounds_setter(int x,int y) {
        int[] final_pos = new int[2];

        //X bounds

        if (x > x_size)
            final_pos[0] = x_size - 1;
        else if (x < 0)
            final_pos[0] = 0;
        else
            final_pos[0] = x - 1;

        //Y bounds

        if (y > y_size)
            final_pos[1] = y_size - 1;
        else if (y < 0)
            final_pos[1] = 0;
        else
            final_pos[1] = y - 1;

        return final_pos;
    }

    void loading_terrain() {
        //Generating squares
        int[] grid_pos;
        int i, j, k;

        for (i = 0; i < x_size; i++)
            for (j = 0; j < y_size; j++)
                grid_squares[i][j] = new Square(new Vector2(i, j));

        //Setting home areas

        for (i = 0; i < home.Length; i++) {
            //Narrowing x and y loops

            for (j = (int)Math.Ceiling(home[i].y - home[i].w); j > -1; j--)
                for (k = (int)Math.Ceiling(home[i].z - home[i].x); k > -1; k--) {
                    grid_pos = bounds_setter(j + (int)Math.Ceiling(home[i].w), k + (int)Math.Ceiling(home[i].x));

                    grid_squares[grid_pos[0]][grid_pos[1]].stat_type = 1;
                }
        }

        //Setting vanguard areas

        for (i = 0; i < vanguard.Length; i++) {
            //Narrowing x and y loops

            for (j = (int)Math.Ceiling(vanguard[i].y - vanguard[i].w); j > -1; j--)
                for (k = (int)Math.Ceiling(vanguard[i].z - vanguard[i].x); k > -1; k--) {
                    grid_pos = bounds_setter(j + (int)Math.Ceiling(vanguard[i].w), k + (int)Math.Ceiling(vanguard[i].x));

                    grid_squares[grid_pos[0]][grid_pos[1]].stat_type = 2;
                }
        }

        //Setting neutral areas

        for (i = 0; i < neutral.Length; i++) {
            //Narrowing x and y loops

            for (j = (int)Math.Ceiling(neutral[i].y - neutral[i].w); j > -1; j--)
                for (k = (int)Math.Ceiling(neutral[i].z - neutral[i].x); k > -1; k--) {
                    grid_pos = bounds_setter(j + (int)Math.Ceiling(neutral[i].w), k + (int)Math.Ceiling(neutral[i].x));

                    grid_squares[grid_pos[0]][grid_pos[1]].stat_type = 3;
                }
        }

        //Setting wells

        for (i = 0; i < wells.Length; i++) {
            grid_pos = bounds_setter(wells[i].x, wells[i].y);

            grid_squares[grid_pos[0]][grid_pos[1]].is_well = true;
        }

        //Setting summoning

        for (i = 0; i < summons.Length; i++) {
            grid_pos = bounds_setter(summons[i].x, summons[i].y);

            grid_squares[grid_pos[0]][grid_pos[1]].is_summoning = true;
        }

        //Setting player bases

        //Player base 1

        grid_pos = bounds_setter(player_base_1.x, player_base_1.y);

        grid_squares[grid_pos[0]][grid_pos[1]].is_base_1 = true;

        //Player base 2

        grid_pos = bounds_setter(player_base_2.x, player_base_2.y);

        //Making sure neither bases overlap

        if (!(grid_squares[grid_pos[0]][grid_pos[1]].is_base_1))
            grid_squares[grid_pos[0]][grid_pos[1]].is_base_2 = true;
        else
        //Just place the base on the other side of the map (there is already the assumption that base 1 is already on the grid)

            grid_squares[x_size - grid_pos[0] - 1][y_size - grid_pos[1] - 1].is_base_2 = true;

        //Setting player areas

        //Player area 1

        for (i = 0; i < player_area_1.Length; i++) {
            //Narrowing x and y loops

            for (j = (int)Math.Ceiling(player_area_1[i].y - player_area_1[i].w); j > -1; j--)
                for (k = (int)Math.Ceiling(player_area_1[i].z - player_area_1[i].x); k > -1; k--) {
                    grid_pos = bounds_setter(j + (int)Math.Ceiling(player_area_1[i].w), k + (int)Math.Ceiling(player_area_1[i].x));

                    grid_squares[grid_pos[0]][grid_pos[1]].player_type = 1;
                }
        }

        //Player area 2

        for (i = 0; i < player_area_2.Length; i++) {
            //Narrowing x and y loops

            for (j = (int)Math.Ceiling(player_area_2[i].y - player_area_2[i].w); j > -1; j--)
                for (k = (int)Math.Ceiling(player_area_2[i].z - player_area_2[i].x); k > -1; k--) {
                    grid_pos = bounds_setter(j + (int)Math.Ceiling(player_area_2[i].w), k + (int)Math.Ceiling(player_area_2[i].x));

                    grid_squares[grid_pos[0]][grid_pos[1]].player_type = 2;
                }
        }
    }

    //Terrain clearer

    public void unloading_terrain() {
        x_size = 0;
        y_size = 0;
       
        Array.Clear(grid_squares,0,grid_squares.Length);

        Array.Clear(home,0,home.Length);
        Array.Clear(vanguard,0,vanguard.Length);
        Array.Clear(neutral,0,neutral.Length);
        Array.Clear(player_area_1,0,player_area_1.Length);
        Array.Clear(player_area_2,0,player_area_2.Length);

        Array.Clear(wells,0,wells.Length);
        Array.Clear(summons,0,summons.Length);

        player_base_1 = new Vector2Int();
        player_base_2 = new Vector2Int();
    }
}
