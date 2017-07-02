function [ depthColorTable sz ] =depthMapColorTable( )
%DEPTHCOLORTABLE() generates a color lookup tabe for depth map
%   Rainbow linea gradient mirros at centre point with gradual dimming
%   starting at the centre point to start of table


gutter = 0.2;
depthColorTable = zeros(512,3, 'uint8');

tableIndex = 257;
step = (1.0 - (gutter * 2.0)) /256;
for t=gutter:step:((1.0-gutter)-step)
    color = zeros(1,3);
    band = 0.7; %Bigger # == move overlap.
    curveExp = 2.0;%original 2.0
    bandGap = 1.0 - band;
    for i=1:3
        s = (t-bandGap*0.5*(i-1))/band;
        if ((s >= 0) && (s <= 1))
           color(i) = power(sin(s * 3.1415927 * 2.0 - 3.1415927 * 0.5) * 0.5 + 0.5, curveExp);
        end
    end
    depthColorTable(tableIndex,1)= uint8(color(1)*255.0);
    depthColorTable(tableIndex,2)= uint8(color(2)*255.0);
    depthColorTable(tableIndex,3)= uint8(color(3)*255.0);
    tableIndex = tableIndex + 1;
end

for i=1:256
    s = depthColorTable(512-i+1,:);
    dim = double((i-1))/256;
    depthColorTable(i,1) = uint8(s(1)*(0.25+0.75*dim));
    depthColorTable(i,2) = uint8(s(2)*(0.25+0.75*dim));
    depthColorTable(i,3) = uint8(s(3)*(0.25+0.75*dim)); 
end
sz = 512;
end

% here are the C code on which the matlab code is based
% COLORREF DepthColorTable[512];
% //
%     // Build depth map visualization color table.
%     //
%     // Rainbow linear gradient mirrored at center point with gradual
%     // dimming starting at center point to start of table.
%     //
%     
%     float gutter = 0.2f;
%     
%     int tableIndex = ARRAYSIZE(DepthColorTable) / 2;
%     float step = (1.0f - (gutter * 2.0f)) / (ARRAYSIZE(DepthColorTable) / 2);
%     for (float t = gutter; t < (1.0f - gutter); t += step)
%     {
%         float color[3] = { 0, 0, 0 };
%         float band = 0.7f; // Bigger # == move overlap.
%         const float curveExp = 2.0f;   
%         const float bandGap = 1.0f - band;
%          
%         for (int i = 0; i < 3; i++) 
%         {
%             float s = (t - bandGap * 0.5f * i) / band;
%             if ((s >= 0) && (s <= 1))
%             {
%                 color[i] = powf(sinf(s * 3.1415927f * 2.0f - 3.1415927f * 0.5f) * 0.5f + 0.5f, curveExp);
%             }
%         }
% 
%         DepthColorTable[tableIndex++] = RGB(
%             (BYTE)(color[0] * 255.0f),
%             (BYTE)(color[1] * 255.0f),
%             (BYTE)(color[2] * 255.0f));
%     }
%     
%     for (int i = 0; i < ARRAYSIZE(DepthColorTable) / 2; i++)
%     {
%         COLORREF s = DepthColorTable[ARRAYSIZE(DepthColorTable) - 1 - i];
%         
%         float dim = (float)i / (float)(ARRAYSIZE(DepthColorTable) / 2);
%         
%         DepthColorTable[i] = RGB(
%             (BYTE)((float)GetRValue(s) * (0.25f + (dim * 0.75f))),
%             (BYTE)((float)GetGValue(s) * (0.25f + (dim * 0.75f))),
%             (BYTE)((float)GetBValue(s) * (0.25f + (dim * 0.75f)))
%             );
%     }
%     

