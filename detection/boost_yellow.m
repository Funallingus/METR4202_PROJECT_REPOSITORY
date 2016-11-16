function result = boost_yellow(image)

imghsv=rgb2hsv(image);



%pick yellow
yellowIndex=repmat((imghsv(:,:,1)>40/360)&(imghsv(:,:,1)<70/360),[1 1 3]);   
yellow=imghsv.*yellowIndex;
%Saturate it
moreSaturation=7;
yellowsaturated=nthroot(yellow(:,:,1), 3);
yellow(:,:,1)=yellowsaturated;
yellowsaturated=yellow(:,:,2)*moreSaturation;
yellow(:,:,2)=yellowsaturated;

%put it back
newHsv=imghsv; 
newHsv(yellowIndex)=yellow(yellowIndex);
result = hsv2rgb(newHsv);

end
%figure(); imshow(result);