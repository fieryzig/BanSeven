all_cards = {
    'ca','c2','c3','c4','c5','c6','c7','c8','c9','c10','cj','cq','ck',
    'da','d2','d3','d4','d5','d6','d7','d8','d9','d10','dj','dq','dk',
    'ha','h2','h3','h4','h5','h6','h7','h8','h9','h10','hj','hq','hk',
    'sa','s2','s3','s4','s5','s6','s7','s8','s9','s10','sj','sq','sk',
};
card1 = {};
card2 = {};
card3 = {};
card4 = {};

swap = function(array, index1, index2)
    array[index1], array[index2] = array[index2], array[index1]
end

shuffle = function(array)
    local n = #array
    while n > 1 do
        local index = math.random(n)
        swap(array, index, n)
        n = n - 1
    end
end

function GetID()
    return 0;
end

function GetCards()
    shuffle(all_cards);
    for i = 1, 13 do table.insert(card1,all_cards[i]); end
    for i = 14, 26 do table.insert(card2,all_cards[i]); end
    for i = 27, 39 do table.insert(card3,all_cards[i]); end
    for i = 40, 52 do table.insert(card4,all_cards[i]); end
    return card1;
end

function ChooseCard()

end

function Controller()

end
