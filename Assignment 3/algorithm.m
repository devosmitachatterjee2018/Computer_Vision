function M = algorithm(x)
M = zeros(length(x{1}),9);

for i = 1:length(x{1})
    xx = x{2}(: , i )* x{1}(: , i )'; 
    M(i ,:) = xx (:)';
end

end