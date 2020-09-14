function CubeTest

AssertOpenGL;

screenid=max(Screen('Screens'));

InitializeMatlabOpenGL(1);

[win , winRect] = Screen('OpenWindow', screenid);

escapeKey = KbName('ESCAPE');
upKey = KbName('UpArrow');
downKey = KbName('DownArrow');
leftKey = KbName('LeftArrow');
rightKey = KbName('RightArrow');


Screen('BeginOpenGL', win);

ar=winRect(4)/winRect(3); 


glEnable(GL_DEPTH_TEST);

glEnable(GL_TEXTURE_2D);

glMatrixMode(GL_PROJECTION);
glLoadIdentity;

gluPerspective(25,1/ar,0.1,100); 

glMatrixMode(GL_MODELVIEW);
glLoadIdentity;

gluLookAt(0,0 ,7 ,0,0,0,0,1,0);

glClearColor(0,0,0,0 );
rotatey1 = 0;
rotatez1 = 0;
rotatey2 = 0;
rotatez2 = 0;
rotatey3 = 0;
rotatez3 = 0;
rotatey4 = 0;
rotatez4 = 0;
whichcube = 0;
blockone = 3;
blocktwo = 3;
blockthree = 3;
blockfour = 3;



while (1)
    
    [x,y,buttons,focus,valuators,valinfo] = GetMouse;
    if buttons(1,1) == 1;
    if x < winRect(3)/2
        if y < winRect(4) - (winRect(4)/4)
            whichcube = 1;
        else
            whichcube = 3;
        end
    elseif x > winRect(3)/2
        if y < winRect(4) - (winRect(4)/4)
            whichcube = 2;
        else
            whichcube = 4;
        end
    end
    end
    [keyIsDown,secs, keyCode] = KbCheck;
    
    if keyCode(escapeKey)
        break;
    end
    if whichcube == 1
    if keyCode(upKey)
        rotatey1 = rotatey1 + 1;
        if rotatey1 == 360 
            rotatey1 = 0;
        end
    elseif keyCode(downKey)
        rotatey1 = rotatey1 - 1;
        if rotatey1 == -360 
            rotatey1 = 0;
        end
    elseif keyCode(leftKey)
        rotatez1 = rotatez1 + 1;
        if rotatez1 == 360 
            rotatez1 = 0;
        end
    elseif keyCode(rightKey)
        rotatez1 = rotatez1 - 1;
        if rotatez1 == -360 
            rotatez1 = 0;
        end
    end
    end
    if whichcube == 2
    if keyCode(upKey)
        rotatey2 = rotatey2 + 1;
        if rotatey2 == 360 
            rotatey2 = 0;
        end
    elseif keyCode(downKey)
        rotatey2 = rotatey2 - 1;
        if rotatey2 == 360 
            rotatey2 = 0;
        end
    elseif keyCode(leftKey)
        rotatez2 = rotatez2 + 1;
        if rotatez2 == 360 
            rotatez2 = 0;
        end
    elseif keyCode(rightKey)
        rotatez2 = rotatez2 - 1;
        if rotatez2 == 360 
            rotatez2 = 0;
        end
    end
    end
    if whichcube == 3
    if keyCode(upKey)
        rotatey3 = rotatey3 + 1;
        if rotatey3 == 360 
            rotatey3 = 0;
        end
    elseif keyCode(downKey)
        rotatey3 = rotatey3 - 1;
        if rotatey3 == 360 
            rotatey3 = 0;
        end
    elseif keyCode(leftKey)
        rotatez3 = rotatez3 + 1;
        if rotatez3 == 360 
            rotatez3 = 0;
        end
    elseif keyCode(rightKey)
        rotatez3 = rotatez3 - 1;
        if rotatez3 == 360 
            rotatez3 = 0;
        end
    end
    end
    if whichcube == 4
    if keyCode(upKey)
        rotatey4 = rotatey4 + 1;
        if rotatey4 == 360 
            rotatey4 = 0;
        end
    elseif keyCode(downKey)
        rotatey4 = rotatey4 - 1;
        if rotatey4 == 360 
            rotatey4 = 0;
        end
    elseif keyCode(leftKey)
        rotatez4 = rotatez4 + 1;
        if rotatez4 == 360 
            rotatez4 = 0;
        end
    elseif keyCode(rightKey)
        rotatez4 = rotatez4 - 1;
        if rotatez4 == 360 
            rotatez4 = 0;
        end
    end
    end
    
    
    
    glPushMatrix;
    glScalef(.55,.55,.55);
    glTranslatef(0  , 1.5  , 0  );
    glClear; 
    stimulus();
    glPopMatrix;
    
    
    glPushMatrix;
    glScalef(.25,.25,.25);
    glTranslatef(-1.25  , -1.5  , 0  ); 
    glRotatef(rotatey1,1,0,0); 
    glRotatef(rotatez1,0,0,1); 
    
    cubeface();
    
    glPopMatrix;
    
    glPushMatrix;
    glScalef(.25,.25,.25);
    glTranslatef(1.25,-1.5,0);  
    glRotatef(rotatey2,1,0,0); 
    glRotatef(rotatez2,0,0,1); 
    cubeface();
    glPopMatrix;
    
    glPushMatrix;
    glScalef(.25,.25,.25);
    glTranslatef(-1.25,-4.25,0); 
    glRotatef(rotatey3,1,0,0); 
    glRotatef(rotatez3,0,0,1);
    cubeface();
    glPopMatrix;
    
    glPushMatrix;
    glScalef(.25,.25,.25);
    glTranslatef(1.25,-4.25,0);  
    glRotatef(rotatey4,1,0,0); 
    glRotatef(rotatez4,0,0,1);
    cubeface();
    glPopMatrix;
    
 
    
    
    
    if rotatey1 < 277 && rotatey1 > 263 || rotatey1 < -263 && rotatey1 > -277 || rotatey1 < 97 && rotatey1 > 83 || rotatey1 < -83 && rotatey1 > -97
        %White(Top/Bottom) correct 
        if rotatez1 > -7 && rotatez1 < 7 || rotatez1 > 173 && rotatez1 < 187 || rotatez1 < -173 && rotatez1 > -187
            blockone = 1;
        end
        %Red(Sides) Correct
        if rotatez1 > 83 && rotatez1 < 97 || rotatez1 > -97 && rotatez1 < -83 || rotatez1 < 277 && rotatez1 > 263 || rotatez1 < -263 && rotatez1 > -277
            blockone = 2;
        end
    end
    %Half(Front/Back) Correct
    if rotatey1 > -7 && rotatey1 < 7 || rotatey1 > 173 && rotatey1 < 187 || rotatey1 > -187 && rotatey1 < -173
        blockone = 3;
    end
    if rotatey2 < 277 && rotatey2 > 263 || rotatey2 < -263 && rotatey2 > -277 || rotatey2 < 97 && rotatey2 > 83 || rotatey2 < -83 && rotatey2 > -97
        %White(Top/Bottom) correct 
        if rotatez2 > -7 && rotatez2 < 7 || rotatez2 > 173 && rotatez2 < 187 || rotatez2 < -173 && rotatez2 > -187
            blocktwo = 1;
        end
        %Red(Sides) Correct
        if rotatez2 > 83 && rotatez2 < 97 || rotatez2 > -97 && rotatez2 < -83 || rotatez2 < 277 && rotatez2 > 263 || rotatez2 < -263 && rotatez2 > -277
            blocktwo = 2;
        end
    end
    %Half(Front/Back) Correct
    if rotatey2 > -7 && rotatey2 < 7 
        if rotatez2 < 97 && rotatez2 > 83 || rotatez2 > -277 && rotatez2 < -263
            blocktwo = 4;
        end
    end
    if rotatey2 > 173 && rotatey2 < 187 || rotatey2 > -187 && rotatey2 < -173
        if rotatez2 > -7 && rotatez2 < 7 
            blocktwo = 4;
        end
    end
    if rotatey3 < 277 && rotatey3 > 263 || rotatey3 < -263 && rotatey3 > -277 || rotatey3 < 97 && rotatey3 > 83 || rotatey3 < -83 && rotatey3 > -97
        %White(Top/Bottom) correct 
        if rotatez3 > -7 && rotatez3 < 7 || rotatez3 > 173 && rotatez3 < 187 || rotatez3 < -173 && rotatez3 > -187
            blockthree = 1;
        end
        %Red(Sides) Correct
        if rotatez3 > 80 && rotatez3 < 100 || rotatez3 > -100 && rotatez3 < -80 || rotatez3 < 280 && rotatez3 > 260 || rotatez3 < -260 && rotatez3 > -280
            blockthree = 2;
        end
    end
    %Half(Front/Back) Correct
    if rotatey3 > -7 && rotatey3 < 7 || rotatey3 > 173 && rotatey3 < 187 || rotatey3 > -187 && rotatey3 < -173
        blockthree = 3;
    end
    if rotatey4 < 277 && rotatey4 > 263 || rotatey4 < -263 && rotatey4 > -277 || rotatey4 < 97 && rotatey4 > 83 || rotatey4 < -83 && rotatey4 > -97
        %White(Top/Bottom) correct 
        if rotatez4 > -7 && rotatez4 < 7 || rotatez4 > 173 && rotatez4 < 187 || rotatez4 < -173 && rotatez4 > -187
            blockfour = 1;
        end
        %Red(Sides) Correct
        if rotatez4 > 83 && rotatez4 < 97 || rotatez4 > -97 && rotatez4 < -83 || rotatez4 < 277 && rotatez4 > 263 || rotatez4 < -263 && rotatez4 > -277
            blockfour = 2;
        end
    end
    %Half(Front/Back) Correct
    if rotatey4 > -7 && rotatey4 < 7 
        if rotatez4 > 173 && rotatez4 < 187 || rotatez4 > -188 && rotatez4 < -173
        blockfour = 4;
        end
    end
    if rotatey4 > 173 && rotatey4 < 187 || rotatey4 > -187 && rotatey4 < -173
        if rotatez4 > 263 && rotatez4 < 277 || rotatez4 > -97 && rotatez4 < -83
        blockfour = 4;
        end
    end
    if blockone == 2 && blocktwo == 4 && blockthree == 2 && blockfour == 4
        
        break
    end
   
    Screen('EndOpenGL', win);
    Screen('Flip', win);
    Screen('BeginOpenGL', win);
   
   
   
    
end

Screen('EndOpenGL', win);

sca;

return



function stimulus()

global GL

glBegin(GL.QUADS);

glColor3f(1, 0, 0);
glVertex3f(-1,1,1);
glVertex3f(0,1,1);
glVertex3f(0,0,1);
glVertex3f(-1,0,1);

glColor3f(1, 0, 0);
glVertex3f(-1,0,1);
glVertex3f(0,0,1);
glVertex3f(0,-1,1);
glVertex3f(-1,-1,1);

glEnd;

glBegin(GL.TRIANGLES);

glColor3f(1, 0, 0);
glVertex3f(1,1,1);
glVertex3f(1,0,1);
glVertex3f(0,0,1);

glColor3f(1, 0, 0);
glVertex3f(1,0,1);
glVertex3f(1,-1,1);
glVertex3f(0,0,1);

glColor3f(1, 1, 1);     
glVertex3f(0, 1,1);
glVertex3f(1, 1,1);
glVertex3f(0, 0,1);

glColor3f(1, 1, 1);     
glVertex3f(0, -1,1);
glVertex3f(1, -1,1);
glVertex3f(0, 0,1);

glEnd;

return

function cubeface()

global GL
 
glBegin(GL.QUADS);

glColor3f(1, 1, 1);     
glVertex3f(1, 1, -1);
glVertex3f(-1, 1, -1);
glVertex3f(-1, 1, 1);
glVertex3f(1, 1, 1);
 
%Bottom face 
glColor3f(1, 1, 1);     
glVertex3f(1, -1, 1);
glVertex3f(-1, -1, 1);
glVertex3f(-1, -1, -1);
glVertex3f(1, -1, -1);
  
%Left face 
glColor3f(1, 0, 0);     
glVertex3f(-1,  1,  1);
glVertex3f(-1,  1, -1);
glVertex3f(-1, -1, -1);
glVertex3f(-1, -1,  1);
 
%Right face 
glColor3f(1, 0, 0);     
glVertex3f(1,  1, -1);
glVertex3f(1,  1,  1); 
glVertex3f(1, -1,  1);
glVertex3f(1, -1, -1);

glEnd;

glBegin(GL.TRIANGLES);
%Front face  
glColor3f(1, 1, 1 );     
glVertex3f(1, 1, 1);
glVertex3f(-1, 1, 1);
glVertex3f(1, -1, 1);

glColor3f(1, 0, 0 );
glVertex3f(-1, 1, 1);
glVertex3f(1, -1, 1);
glVertex3f(-1, -1, 1);

%Back face  
glColor3f(1, 1, 1);     
glVertex3f(1, -1, -1);
glVertex3f(-1, -1, -1);
glVertex3f(-1,  1, -1);

glColor3f(1, 0, 0);     
glVertex3f(1, -1, -1);
glVertex3f(-1,  1, -1);
glVertex3f(1, 1, -1);

glEnd;

 return