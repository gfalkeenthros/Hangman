module GameState
(
    GameState (GameState, word, guessed, lives),
    getHitsAndMisses,
    getRights,
    getWrongs,
    printState,
    gameWon,
    gameLost
)
where

import Data.List
import Control.Monad

data GameState = GameState { 
    word :: String, 
    guessed :: [Char],
    lives :: Int
    } 

printState :: GameState -> IO ()
printState state = do
    putStr "Lives: "
    print $ lives state - length (getWrongs state)
    let guessedChars = getWrongs state
    unless (null guessedChars) $ putStrLn ("You've already guessed: " ++ intersperse ',' guessedChars) 
    let secretWord = [if c `elem` guessed state then c else '_' | c <- word state]
    putStrLn secretWord

getHitsAndMisses :: GameState -> ([Char], [Char])
getHitsAndMisses state = partition (`elem` word state) $ guessed state

getWrongs :: GameState -> [Char]
getWrongs = snd . getHitsAndMisses

getRights :: GameState -> [Char]
getRights = fst . getHitsAndMisses

gameWon :: GameState -> Bool
gameWon state = all (`elem` guessed state) $ word state

gameLost :: GameState -> Bool
gameLost state = lives state == length (getWrongs state)