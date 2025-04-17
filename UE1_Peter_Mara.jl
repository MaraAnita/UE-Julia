
#=
Fuege in dieses Template deine Loesungscodes ein.
Wichtig 1: Die Datei gemaess der Namensrichtlinien benennen.
Wichtig 2: Bitte nur die Funktionen ausprogrammieren und keine Funktionsaufrufe vornehmen.
=#


### Beispiel 1:

function greatest(x::Vector{T}, k::Integer = 1) :: Vector{T} where {T <: Real}

    # Deie Funktion sucht die k groessten Werte von x
    # x ... Vektor
    # k ... Wert (Integer), default = 1

    # laenge von x speichern, da wir sie oefter brauchen
    len = length(x)

    # Informative Fehlermeldung
    if k > len || k <= 0
        throw(DomainError(k, "k must be > 0 and ≤ length of x"))
    end

    # x sortieren und die groessten k finden
    big = sort(x)[len - k + 1 : len]
    
    # ergebnisvektor initialisieren
    index = Int[]
    # fuer jedes x und jedes big ueberpruefen, ob sie gleich sind
    for i in 1:k
        for j in 1:len

            if big[i] == x[j]
                #index um den index verlängern
                push!(index, j) 
            end
        end
    end

    # x and der stelle der sortierten indizes
    ergebnis = x[sort(index)]

    # Ergebnis ausgeben
    return ergebnis
end

### Beispiel 2

function nearestindex(x::Vector{<:Real}, y::Real) :: Int
    
    # Die Funktion findet den index des zu y naechsgelegenen Wertes in x
    # x ... Vektor
    # y ... Wert

    # laenge von x speichern
    len = length(x)

    # Differenz mehreren x unde einem y
    differ = x .- y

    # Vektor initialiesieren
    absolut = []
    # Schleife, um Betrag zu berechnen
    for i in 1:len
        push!(absolut, abs(differ[i]))
    end
    
    # kleinsten Wert herausfinden
    mini = sort(absolut)[1]

    # index initialisiern
    index = []
    # herausfinden, wo der kleinste Wert wohnt
    # Schleife ueber alle Werte
    for j in 1:len

        # Falls der Wert an dieser Stell der kleinste Wert ist:
        if mini == absolut[j]
            
            # index um den index verlaengern
            push!(index, j)
            
        end
    end

    # sample, fall 2 gleich weit weg sind
    ergebnis = sample(index)

    # ergebnis zurueckgeben
    return ergebnis
end


### Beispiel 3

function swap!(x::Vector, i::Integer, j::Integer) :: Nothing
    # Die funktion tauscht die Werte 2er Stellen eines Vektors x 
    # dabei wird x veraendert!!!
    # x ... Vektor
    # i ... 1. Stelle
    # j ... 2. Stelle

    save = x[i]     # xi speichern
    x[i] = x[j]     # xi durch xj ersetzen
    x[j] = save     # xj durch das gespeicherte xi ersetzen

    return
end

function bubblesort!(x::Vector{<:Real}; rev::Bool = false) :: Nothing

    # Die Funktion sortiert den Vektor x nach groesse
    # dabei wird x veraendert!!!
    # x ... Vektor
    # rev = false ... es wird aufsteigend sortiert, defaultwert
    # rev = true ... es wird absteigend sortiert

    # Laenge von x speichern
    len = length(x)

    # Schleife fuer die insgesamten Durchgaenge
    for j in 1:(len - 1)

        # Schleife fuer die Vergleiche zwischen den Eementen
        # beim 2-ten insgesamten durchgang muss das letzte nicht mehr verglichen werden
        for i in 1:(len-j)

            # falls das linke groesser als das rechte:
            if x[i] > x[i+1]

                # tauschen
                swap!(x, i, i+1)

            end  
        end
    end

    ## falls reverse = true: es soll absteigend sortiert werden
    # Also: ganzen sortierten aufsteigenden Vektor umdrehen
    if rev == true
        reverse!(x)
    end

    return
end


### Beispiel 4

function canonicaltour(x::Vector{T}) :: Vector{T} where {T <: Integer}

    # Die Funktion berechnet die kanonische tour einer Reise x
    # x ... Vektor, Permuation von 1:length(x)

    # Laenge von x speichern
    len = length(x)

    ## informative Fehlermeldung:
    # 1:length(x) als vektor erzeugen
    y = [1]
    for i in 2:len
        push!(y, i)
    end
    # falls das nicht gleich
    if sort(x) != y
        # Fehlermeldung
        throw(DomainError(x, "x must be a permutation of the numbers 1:length(x) :("))
    end

    ## Berechnungen
    # Die 1-er Stadt finden
    eins = findmin(x)[2]
    
    # die erste Stelle der Reise ist immer 1-er Stadt
    reise = [1]



    # If fuer verschiedene orte von Stadt 1
    if eins == 1               # 1 ist am Anfang
        anfang = []                 # Abschnitt bis zur 1-er Stadt
        ende = x[2:len]             # Abschnitt ab der 1-er Stadt

        # Die 2-te Stadt soll kleiner sein als die n-te
        # Daher: Falls die vor 1 kleiner als die nach 1:
        if ende[end] < ende[1]
        
            reverse!(anfang)            # Anfang umdrehen
            reverse!(ende)              # Ende umdrehen
            append!(anfang, ende)       # Ende an Anfang anhaengen
            append!(reise, anfang)      # Die Reise um den rest der Reise verlaengern

        else
            # Fall s die vor 1 groesser als die nach 1:
            append!(ende, anfang)   # anfang an ende anhaengen
            append!(reise, ende)    # reise um den rest der reise verlaengern
        
        end



    elseif eins == len         # 1 ist am Ende
        anfang = x[1:len-1]         # Abschnitt bis zur 1-er Stadt
        ende = []                   # Abschnitt ab der 1-er Stadt

        # Die 2-te Stadt soll kleiner sein als die n-te
        # Daher: Falls die vor 1 kleiner als die nach 1:
        if anfang[end] < anfang[1]
        
            reverse!(anfang)            # Anfang umdrehen
            reverse!(ende)              # Ende umdrehen
            append!(anfang, ende)       # Ende an Anfang anhaengen
            append!(reise, anfang)      # Die Reise um den rest der Reise verlaengern

        else
            # Fall s die vor 1 groesser als die nach 1:
            append!(ende, anfang)   # anfang an ende anhaengen
            append!(reise, ende)    # reise um den rest der reise verlaengern
        
        end



    else                        # 1 ist in der Mitte
        anfang = x[1:eins - 1]      # Abschnitt bis zur 1-er Stadt
        ende = x[eins + 1:len]      # Abschnitt ab der 1-er Stadt
    
        # Die 2-te Stadt soll kleiner sein als die n-te
        # Daher: Falls die vor 1 kleiner als die nach 1:
        if anfang[end] < ende[1]
        
            reverse!(anfang)            # Anfang umdrehen
            reverse!(ende)              # Ende umdrehen
            append!(anfang, ende)       # Ende an Anfang anhaengen
            append!(reise, anfang)      # Die Reise um den rest der Reise verlaengern

        else
            # Fall s die vor 1 groesser als die nach 1:
            append!(ende, anfang)   # anfang an ende anhaengen
            append!(reise, ende)    # reise um den rest der reise verlaengern
        
        end
    
    
    
    
    
    end
    

    # fertige reise ausgeben
    return reise
end


### Beispiel 5

function distance(x::Vector{<:Real}, y::Vector{<:Real}; p::Real = 2)

    # Die Funktion berechnet die p-Distanz zwischen zwei Vektoren x und y
    # x, y gleich lang
    # p ist > 0, defaultwert = 2

    # Laenge von x speichern
    len = length(x)

    ## Fehlermeldungen
    # Ist die Laenge von x = Laenge von y? Falls nicht Fehlermeldung
    if len != length(y)
        # Fehlermeldung
        throw(DomainError("x and y must have the same length :("))
    end

    # Ist p > 0? Falls nicht Fehlermeldung
    if p ≤ 0
        # Fehlermeldung
        throw(DomainError(p, "p must be > 0 :("))
    end

    ## Berechnung
    # Elementweise differnz zwischen x und y berechen
    differ = x .- y

    # Vektor initialiesieren
    absolut = []
    # Schleife, um Betrag zu berechnen, falls p ungerade
    for i in 1:len
        # Vektor mit Betraegen wird immer um den naechsen Betrag verlaengert
        push!(absolut, abs(differ[i]))
    end

    # betrag elementweise hoch p, alles addieren, p-te wurzel ziehen
    ergeb = (sum(absolut.^p))^(1/p)

    # Ergebnis ausgeben
    return ergeb
end

