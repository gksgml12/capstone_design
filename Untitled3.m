lds_data = ones(60,2)

for i=1:length(lds_data)-5
    for j=1:4
        m = zeros(4,1);
        m(i) = (lds_data(j,1)-lds_data(j+1,1))/(lds_data(j,2)-lds_data(j+1,2));
    end
    for k=1:3
        m_dif = 0;
        m_dif = abs(m(i)-m(i+1))+m_dif;
    end
    m_dif/3
end
    