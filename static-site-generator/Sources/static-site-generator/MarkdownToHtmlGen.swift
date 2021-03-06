//
//  HtmlWalker.swift
//  
//
//  Created by Ido Mizrachi on 07/06/2022.
//

import Foundation
import Markdown

struct Metadata {
    var title: String? = nil
    var subtitle: String? = nil
    var tags: [String] = []
    var date: PostDate?
}

struct MarkdownToHtmlGen: MarkupWalker {
    
    var metadata = Metadata()
    var html: String = ""
    
    var isParsingMetadata: Bool = true  // Metadata ends at the first ThematicBreak element, text is: ---
    
    
    /**
     A default implementation to use when a visitor method isn't implemented for a particular element.
     - parameter markup: the element to visit.
     - returns: The result of the visit.
     */
//    mutating func defaultVisit(_ markup: Markup) {
//
//    }

    /**
     Visit any kind of `Markup` element and return the result.

     - parameter markup: Any kind of `Markup` element.
     - returns: The result of the visit.
     */
//    mutating func visit(_ markup: Markup) {
//    }

    /**
     Visit a `BlockQuote` element and return the result.

     - parameter blockQuote: A `BlockQuote` element.
     - returns: The result of the visit.
     */
    mutating func visitBlockQuote(_ blockQuote: BlockQuote) {
//        print("block quote:\n\(blockQuote.format())")
        html.append("""
        <blockquote class="blockquote"><p>\(blockQuote.format())</p></blockquote>
        
        """)
    }

    /**
     Visit a `CodeBlock` element and return the result.

     - parameter codeBlock: An `CodeBlock` element.
     - returns: The result of the visit.
     */
    mutating func visitCodeBlock(_ codeBlock: CodeBlock) {
        let language = codeBlock.language ?? "plaintext"
//        print("code block:\n\(codeBlock.code)")
        html.append("""
        <pre><code class="language-\(language) highlighter-rouge">
        \(codeBlock.code)
        </code></pre>
        
        """)
        
    }

    /**
     Visit a `CustomBlock` element and return the result.

     - parameter customBlock: An `CustomBlock` element.
     - returns: The result of the visit.
     */
    mutating func visitCustomBlock(_ customBlock: CustomBlock) {
        print("custom block:\n\(customBlock.format())")
        assertionFailure("Missing implementation")
    }

    /**
     Visit a `Document` element and return the result.

     - parameter document: An `Document` element.
     - returns: The result of the visit.
     */
//    mutating func visitDocument(_ document: Document) {
//
//    }

    /**
     Visit a `Heading` element and return the result.

     - parameter heading: An `Heading` element.
     - returns: The result of the visit.
     */
    mutating func visitHeading(_ heading: Heading) {
//        print("heading:\n\(heading.plainText)")
        let level = heading.level
        html.append("""
        <h\(level)>\(heading.plainText)</h\(level)>
        
        """)
    }

    /**
     Visit a `ThematicBreak` element and return the result.

     - parameter thematicBreak: An `ThematicBreak` element.
     - returns: The result of the visit.
     */
    mutating func visitThematicBreak(_ thematicBreak: ThematicBreak) {
        if isParsingMetadata {
            isParsingMetadata = false
            print("Finished parsing metadata \(metadata)")
        } else {
            html.append("""
            <hr>
            
            """)
        }
//        print("thematic break:\n\(thematicBreak.format())")
    }
    
    /**
     Visit an `HTML` element and return the result.

     - parameter html: An `HTML` element.
     - returns: The result of the visit.
     */
    mutating func visitHTMLBlock(_ htmlBlock: HTMLBlock) {
//        print("html block:\n\(htmlBlock.rawHTML)")
        html.append("""
        \(htmlBlock.rawHTML)
        
        """)
    }

    /**
     Visit a `ListItem` element and return the result.

     - parameter listItem: An `ListItem` element.
     - returns: The result of the visit.
     */
    mutating func visitListItem(_ listItem: ListItem) {
        print("\(listItem.format())")
        assertionFailure("Not supported for function: \(#function)")
    }

    /**
     Visit a `OrderedList` element and return the result.

     - parameter orderedList: An `OrderedList` element.
     - returns: The result of the visit.
     */
    mutating func visitOrderedList(_ orderedList: OrderedList) {
//        print("orders list:\n\(orderedList.format())")
        html.append("<ol>")
        for (index, listItem) in orderedList.listItems.enumerated() {
            html.append("<li>")
//            handleListItem(listItem: listItem)
//            print("\(item.format())")
//            print("index: \(index), index in parent: \(item.indexInParent), checkbox: \(item.checkbox)")
//            print("Child count: \(item.childCount)")
//            print("Children: \(item.children)")
//            print("Block children: \(item.blockChildren.c)")
            listItem.children.forEach { child in
                child.accept(&self)
            }
            html.append("</li>\n")
        }
        html.append("</ol>\n")
    }
    
    mutating func handleListItem(listItem: ListItem) {
//        print("\(listItem.debugDescription())")
        for (index, item) in listItem.children.enumerated() {
//            print("item: \(item)")
            item.accept(&self)
        }
    }
    

    /**
     Visit a `UnorderedList` element and return the result.

     - parameter unorderedList: An `UnorderedList` element.
     - returns: The result of the visit.
     */
    mutating func visitUnorderedList(_ unorderedList: UnorderedList) {
//        print("unorders list:\n\(unorderedList.format())")
        html.append("<ul>\n")
        for (index, listItem) in unorderedList.listItems.enumerated() {
            html.append("<li>\n")
//            handleListItem(listItem: listItem)
//            print("\(item.format())")
//            print("index: \(index), index in parent: \(item.indexInParent), checkbox: \(item.checkbox)")
//            print("Child count: \(item.childCount)")
//            print("Children: \(item.children)")
//            print("Block children: \(item.blockChildren.c)")
            listItem.children.forEach { child in
                child.accept(&self)
            }
            html.append("</li>\n")
        }
        html.append("</ul>\n")
    }

    /**
     Visit a `Paragraph` element and return the result.

     - parameter paragraph: An `Paragraph` element.
     - returns: The result of the visit.
     */
    mutating func visitParagraph(_ paragraph: Paragraph) {
        if isParsingMetadata {
            parseMetadataFields(paragraph: paragraph)
        } else {
            html.append("<p>\n")
            paragraph.children.forEach { child in
                child.accept(&self)
            }
            html.append("</p>\n")
//            html.append("""
//            <p>\(paragraph.plainText)</p>
//
//            """)
        }
//        print("paragraph:\n\(paragraph.plainText)")
    }
    
    

    /**
     Visit a `BlockDirective` element and return the result.

     - parameter blockDirective: A `BlockDirective` element.
     - returns: The result of the visit.
     */
    mutating func visitBlockDirective(_ blockDirective: BlockDirective) {
        print("block directive:\n\(blockDirective.format())")
        assertionFailure("Not supported for function: \(#function)")
    }

    /**
     Visit a `InlineCode` element and return the result.

     - parameter inlineCode: An `InlineCode` element.
     - returns: The result of the visit.
     */
    mutating func visitInlineCode(_ inlineCode: InlineCode) {
//        print("inline code:\n\(inlineCode.plainText)")
        var code = inlineCode.plainText
        let from = code.index(code.startIndex, offsetBy: 1)
        let to = code.index(code.endIndex, offsetBy: -2)
        code = String(code[from...to])
        html.append("""
        <code class="language-swift highlighter-rouge">\(code)</code>
        """)
    }

    /**
     Visit a `CustomInline` element and return the result.

     - parameter customInline: An `CustomInline` element.
     - returns: The result of the visit.
     */
    mutating func visitCustomInline(_ customInline: CustomInline) {
        print("custom inline:\n\(customInline.plainText)")
        assertionFailure("Not supported for function: \(#function)")
    }

    /**
     Visit a `Emphasis` element and return the result.

     - parameter emphasis: An `Emphasis` element.
     - returns: The result of the visit.
     */
//    mutating func visitEmphasis(_ emphasis: Emphasis) {
//        print("emphasis:\n\(emphasis.plainText)")
//    }

    /**
     Visit a `Image` element and return the result.

     - parameter image: An `Image` element.
     - returns: The result of the visit.
     */
    mutating func visitImage(_ image: Image) {
//        print("image:\n\(image.plainText)")
        html.append("""
        <img src="\(image.source ?? "")" alt="\(image.plainText)">
        """)
//        assertionFailure("Not supported for function: \(#function)")
    }

    /**
     Visit a `InlineHTML` element and return the result.

     - parameter inlineHTML: An `InlineHTML` element.
     - returns: The result of the visit.
     */
    mutating func visitInlineHTML(_ inlineHTML: InlineHTML) {
//        print("inline html:\n\(inlineHTML.plainText)")
        html.append(inlineHTML.plainText)
    }

    /**
     Visit a `LineBreak` element and return the result.

     - parameter lineBreak: An `LineBreak` element.
     - returns: The result of the visit.
     */
    mutating func visitLineBreak(_ lineBreak: LineBreak) {
        print("line break:\n\(lineBreak.plainText)")
        assertionFailure("Not supported for function: \(#function)")
    }

    /**
     Visit a `Link` element and return the result.

     - parameter link: An `Link` element.
     - returns: The result of the visit.
     */
    mutating func visitLink(_ link: Link) {
        print("link:\n\(link.plainText)")
        assertionFailure("Not supported for function: \(#function)")
    }
    
    /**
     Visit a `SoftBreak` element and return the result.

     - parameter softBreak: An `SoftBreak` element.
     - returns: The result of the visit.
     */
    mutating func visitSoftBreak(_ softBreak: SoftBreak) {
//        print("soft break:\n\(softBreak.plainText)")
//        assertionFailure("Not supported for function: \(#function)")
        html.append("<br>")
    }
    /**
     Visit a `Strong` element and return the result.

     - parameter strong: An `Strong` element.
     - returns: The result of the visit.
     */
    mutating func visitStrong(_ strong: Strong) {
//        print("strong:\n\(strong.plainText)")
//        assertionFailure("Not supported for function: \(#function)")
        html.append("""
        <strong>\(strong.plainText)</strong>
        """)
    }

    /**
     Visit a `Text` element and return the result.

     - parameter text: A `Text` element.
     - returns: The result of the visit.
     */
    mutating func visitText(_ text: Text) {
//        print("text:\n\(text.plainText)")
//        html.append(text.plainText)
        html.append("""
        <span>\(text.plainText)</span>
        """)
    }
    

    /**
     Visit a `Strikethrough` element and return the result.

     - parameter strikethrough: A `Strikethrough` element.
     - returns: The result of the visit.
     */
    mutating func visitStrikethrough(_ strikethrough: Strikethrough) {
//        print("strike through:\n\(strikethrough.plainText)")
        html.append("""
        <del>\(strikethrough.plainText)</del>
        """)
    }

    /**
     Visit a `Table` element and return the result.

     - parameter table: A `Table` element.
     - returns: The result of the visit.
     */
    mutating func visitTable(_ table: Table) {
        print("table:\n\(table.format())")
        assertionFailure("Not supported for function: \(#function)")
    }

    /**
     Visit a `Table.Head` element and return the result.

     - parameter tableHead: A `Table.Head` element.
     - returns: The result of the visit.
     */
    mutating func visitTableHead(_ tableHead: Table.Head) {
        print("table head:\n\(tableHead.format())")
        assertionFailure("Not supported for function: \(#function)")
    }

    /**
     Visit a `Table.Body` element and return the result.

     - parameter tableBody: A `Table.Body` element.
     - returns: The result of the visit.
     */
    mutating func visitTableBody(_ tableBody: Table.Body) {
        print("table body:\n\(tableBody.format())")
        assertionFailure("Not supported for function: \(#function)")
    }

    /**
     Visit a `Table.Row` element and return the result.

     - parameter tableRow: A `Table.Row` element.
     - returns: The result of the visit.
     */
    mutating func visitTableRow(_ tableRow: Table.Row) {
        print("table row:\n\(tableRow.format())")
        assertionFailure("Not supported for function: \(#function)")
    }

    /**
     Visit a `Table.Cell` element and return the result.

     - parameter tableCell: A `Table.Cell` element.
     - returns: The result of the visit.
     */
    mutating func visitTableCell(_ tableCell: Table.Cell) {
        print("table cell:\n\(tableCell.plainText)")
        assertionFailure("Not supported for function: \(#function)")
    }

    /**
     Visit a `SymbolLink` element and return the result.

     - parameter symbolLink: A `SymbolLink` element.
     - returns: The result of the visit.
     */
    mutating func visitSymbolLink(_ symbolLink: SymbolLink) {
        print("symbol link:\n\(symbolLink.plainText)")
        assertionFailure("Not supported for function: \(#function)")
    }
        
    private mutating func parseMetadataFields(paragraph: Paragraph) {
//        if paragraph.plainText.hasPrefix("title: ") {
//            let titleHeaderCount = "title: ".count
//            let skipTitleHeader = paragraph.plainText.index(paragraph.plainText.startIndex, offsetBy: titleHeaderCount)
//            title = String(paragraph.plainText[skipTitleHeader...]).trimmingCharacters(in: .whitespacesAndNewlines)
//        }
        if let title = parseMetadataField(header: "title", paragraph: paragraph) {
            self.metadata.title = title
        }
        
//        if paragraph.plainText.hasPrefix("tags: ") {
//            let tagsHeaderCount = "tags: ".count
//            let skipTagsHeader = paragraph.plainText.index(paragraph.plainText.startIndex, offsetBy: tagsHeaderCount)
//            tags = String(paragraph.plainText[skipTagsHeader...]).split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
//        }
        if let tags = parseMetadataField(header: "tags", paragraph: paragraph) {
            self.metadata.tags = tags.split(separator: ",").map {
                $0.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        if let date = parseMetadataField(header: "date", paragraph: paragraph) {
            do {
                self.metadata.date = try parseDate(string: date)
            } catch {
                fatalError("Post is date contains invalid format \(String(describing: self.metadata.title)) \(String(describing: self.metadata.subtitle))")
            }
        }
        
        
        if let subtitle = parseMetadataField(header: "subtitle", paragraph: paragraph) {
            self.metadata.subtitle = subtitle
        }
    }
    
    private func parseMetadataField(header: String, paragraph: Paragraph) -> String? {
        guard paragraph.plainText.hasPrefix("\(header): ") else {
            return nil
        }
        let headerCharactersCount = "\(header): ".count
        let skipHeader = paragraph.plainText.index(paragraph.plainText.startIndex, offsetBy: headerCharactersCount)
        return String(paragraph.plainText[skipHeader...])
    }
    
    private func parseDate(string: String?) throws -> PostDate {
        guard let string = string else {
            throw MissingPostDate()
        }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: string) else {
            throw MissingPostDate()
        }
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        guard
            let year = dateComponents.year,
            let month = dateComponents.month,
            let day = dateComponents.day
        else {
            throw MissingPostDate()
        }
        return PostDate(year: year, month: month, day: day, date: date)
    }
}
