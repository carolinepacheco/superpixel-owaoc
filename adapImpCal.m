function  [TwClas] = adapImpCal(nPool, aPool, accuracyClas, impFeature)


T = 1;
t = 0;
TwClas  = struct([]);

while t < T

normalize = 0;
t = t + 1;

for j = 1:nPool %10

    checkClassifier = isempty(aPool{j});

    if checkClassifier == 0


        TwClas{j} =   impFeature{j} + aPool{j} - (accuracyClas)/(t + 0);

        if TwClas{j} > 0

            normalize = normalize +  TwClas{j};

        else

            TwClas{j} = 0;
        end
    else
        TwClas{j} = [];
    end
end

if normalize <= 0
    TwClas{T} = impFeature{j}; % alterar
    t = T;
else
     for j = 1:size(aPool,2) %10

        checkClassifier = isempty(aPool{j});

        if checkClassifier == 0
        TwClas{j} = TwClas{j}/normalize;
        end
    end

end
end
end

    