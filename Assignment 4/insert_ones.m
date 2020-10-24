function [Xs] = insert_ones(Xs)
Xs = [Xs;ones(1,size(Xs,2))];
end