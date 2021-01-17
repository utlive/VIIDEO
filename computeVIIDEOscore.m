function VIIDEOscoreval =  computeVIIDEOscore(vidname,height,width, ...
                           framenumber,blocksizerow,blocksizecol,...
                           blockrowoverlap,blockcoloverlap,filtlength)
%--------------------------------------------------------------------------
% Feature Computation

framevector  = 1:2:framenumber-1;
count        = 1;
for frameitr = framevector   

    [ydis1 ydis2]           = readframe(vidname,frameitr,height,width);
    [feat]                  = computeVIIDEOfeaturevector(ydis1,ydis2,...
                              blocksizerow,blocksizecol,blockrowoverlap, ...
                              blockcoloverlap,filtlength);
    param(count).featvect   = feat;
    count                   = count +1;     
       
end


% Score Computation
VIIDEOscorevect             = computeVIIDEOscorevector(param);
VIIDEOscoreval              = computefinalscore(VIIDEOscorevect);


%--------------------------------------------------------------------------
%-------------------------------------------------------------------------
function VIIDEOscoreval     = computefinalscore(VIIDEOscorevect)

tpscore                     = (VIIDEOscorevect);


tpscore_shifted             = circshift(tpscore,[1 0]);
change_score                = abs(tpscore_shifted -tpscore);
VIIDEOscoreval              = [nanmean(tpscore)+nanmean(change_score)];



%-------------------------------------------------------------------------
function VIIDEOscorevect = computeVIIDEOscorevector(param)

len                   = size(param,2)-1;
gap                   = floor(len/10);
VIIDEOscorevect       = [];
for itr               = 1:round(gap/2):len
    
    f1_cum            = [];
    f2_cum            = [];
    
    for itr_param     = itr:min(itr+gap,len)
        
        low_Fr1       =  [param(itr_param).featvect(:,3:14) ];
        low_Fr2       =  [param(itr_param+1).featvect(:,3:14)];
        
        high_Fr1      =  [param(itr_param).featvect(:,17:28)  ];
        high_Fr2      =  [param(itr_param+1).featvect(:,17:28)];
        
        vec1          = abs(low_Fr1 - low_Fr2);
        vec2          = abs(high_Fr1- high_Fr2);
        
        
        [IDX    col]  = find(isinf(vec1)|isnan(vec1)|...
                          isinf(vec2)|isnan(vec2));
        
        vec1(IDX,:)   = [];
        vec2(IDX,:)   = [];
        
        
        if(~isempty(vec1))
            f1_cum    = [f1_cum; vec1];
            f2_cum    = [f2_cum; vec2];
        end
        
    end   
   if(~isempty(f1_cum))
    C                 = diag(corr(f1_cum,f2_cum));
    VIIDEOscorevect   = [ VIIDEOscorevect;mean(C(:))];
   end
end

%--------------------------------------------------------------------------
function [featvect] = computeVIIDEOfeaturevector(ydis1,ydis2, ...
    blocksizerow,blocksizecol,blockrowoverlap,blockcoloverlap,filtlength)


warning('off')
shifts          = [1 0; 0 1; 1 1; 1 -1];
window          = fspecial('gaussian',filtlength,mean(filtlength)/6);
window          = window/sum(sum(window));

featvect        = [];

temporalsignal  = ydis1-ydis2;


for itr =1:2
    
X                        = temporalsignal;
mu_X                     = imfilter(X,window,'replicate');
mu_sq                    = mu_X.*mu_X;
sigma_X                  = sqrt(abs(imfilter(X.*X,window,'replicate')- mu_sq));

structdis                = (X-mu_X)./(sigma_X+1);

feat                     = computefeatvect(structdis,blocksizerow,...
                           blocksizecol,blockrowoverlap,blockcoloverlap);
featvect                 = [featvect feat(:,1) (feat(:,2)+feat(:,3))/2]; 

for itr_shift = 1:4
    
structdis_shifted        = circshift(structdis,shifts(itr_shift,:));
feat                     = computefeatvect(structdis.*structdis_shifted, ...
                           blocksizerow,blocksizecol,...
                           blockrowoverlap,blockcoloverlap);
featvect                 = [featvect feat]; 

end

temporalsignal          = mu_X;

end
%--------------------------------------------------------------------------
function [feat]          = computefeatvect(structdis,blocksizerow,blocksizecol,...
                           blockrowoverlap,blockcoloverlap)
                       
featnum                  = 3;
feat                     = blkproc(structdis,[blocksizerow  blocksizecol],...
                         [ blockrowoverlap blockcoloverlap],@estimateaggdparam);
feat                     = reshape(feat,[featnum size(feat,1)*size(feat,2)/featnum]);
feat                     = feat';
feat                     = [feat(:,1) feat(:,2) feat(:,3)];


%--------------------------------------------------------------------------
function feat      = estimateaggdparam(vec)

vec                = vec(:);

if(sum(abs(vec(:))))
    
gam                = 0.2:0.01:5;
r_gam              = ((gamma(2./gam)).^2)./(gamma(1./gam).*gamma(3./gam));
leftstd            = sqrt(mean((vec(vec<0)).^2));
rightstd           = sqrt(mean((vec(vec>0)).^2));
gammahat           = leftstd/rightstd;
rhat               = (mean(abs(vec)))^2/mean((vec).^2);
rhatnorm           = (rhat*(gammahat^3 +1)*(gammahat+1))/((gammahat^2 +1)^2);
[min_difference,...
   array_position] = min((r_gam - rhatnorm).^2);
alpha              = gam(array_position);
betal              = leftstd *sqrt(gamma(1/alpha)/gamma(3/alpha));
betar              = rightstd*sqrt(gamma(1/alpha)/gamma(3/alpha));
feat               = [alpha;betal;betar];

else
    
feat               = [inf; inf ; inf];

end
%--------------------------------------------------------------------------
function [y1 y2]  =  readframe(vidfilename, framenum,height,width)

fid                  =  fopen(vidfilename);

fseek(fid,(framenum-1)*width*height*1.5,'bof');

y1           = fread(fid,width*height, 'uchar')';
y1           = reshape(y1,[width height]);
y1           = y1'; 

fseek(fid,(framenum)*width*height*1.5,'bof');

y2           = fread(fid,width*height, 'uchar')';
y2           = reshape(y2,[width height]);
y2           = y2'; 

fclose(fid);
%--------------------------------------------------------------------------

