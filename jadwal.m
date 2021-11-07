function[sa]=jadwal(time)
N = randi([50 70]);
%sa = zeros(1,N);
k=randi([1 60]);    

for iii=1:N
    k=k+(60*(randi([1 4])));
    sa(1,iii)=k;
    if k>time
        return
    end
    
end
end

