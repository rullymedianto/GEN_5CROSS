function[sa]=jadwal(time)
N = randi([5 40]);
%sa = zeros(1,N);
k=randi([1 30]);    

for iii=1:N
    k=k+(60*(randi([2 4])));
    sa(1,iii)=k;
    if k>time
        return
    end
    
end
end

