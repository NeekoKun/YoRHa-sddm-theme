import QtQuick 2.11

QtObject {
    property var quotes: [
        [ "I taught the children what fear is. I felt they had to know so they wouldn't heedlessly run into danger. But... instead...", "Pascal" ],
        [ "Do you think games are silly little things?", "Yoko Taro" ],
        [ "I seek to learn and adopt all facets of humanity! Some desire love! Others family! Only then did I realize the truth...the core of humanity... is conflict. They fight. Steal. Kill. This is humanity in its purest form!", "Adam" ],
        [ "We've destroyed machines beyond counting. Perhaps someone sees that as a sin.", "2B" ],
        [ "The more of a fool people take you for, the more you'll learn of their true nature.", "a Weird Machine" ],
        [ "A future is not given to you. It is something you must take for yourself.", "Pod 042" ],
        [ "It always ends like this.", "2B" ],
        [ "I never quite realized... how beautiful this world is.", "A2" ],
        [ "Do not feel bad about it. We are alive, after all. And being alive is pretty much a constant stream of embarrassment.", "Pod 153" ],
        [ "Everything that lives is designed to end. They are perpetually trapped in a never-ending spiral of life and death. However, life is all about the struggle within this cycle. That is what 'we' believe.", "Pod 153" ]
    ]

    property int quotesCount: quotes.length
}