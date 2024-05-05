//
//  PostRowViewModel.swift
//  GeoStream
//
//  Created by Matthew Dowling on 5/4/24.
//

import Foundation

@MainActor
class PostRowViewModel: ObservableObject {
    @Published var showComment = false
    @Published var post: Post
    @Published var user: User?
    @Published var comments = [Comment]()
    @Published var isLiked: Bool?
    
    init(post: Post, user: User?) {
        self.post = post
        self.user = user
        fetchComments()
        isPostLiked()
    }
    
    func toggleShowComment() {
        showComment.toggle()
    }
    
    func fetchComments() {
        Task {
            do {
                guard let postId = post.id else { return }
                let fetchedComments = await PostService.shared.fetchComments(postId)
                comments = fetchedComments
                //print("[DEBUG] PostRowViewModel:fetchComments() comments: \(comments)")
            } catch {
                print("[DEBUG ERROR] PostRowViewModel:fetchComments() Error: \(error.localizedDescription)")
            }
        }
    }
    
    func isPostLiked() {
        if let user = user, let id = post.id {
            if user.favPost.contains(id) {
                isLiked = true
            } else {
                isLiked = false
            }
        } else {return}
    }
    
    func deletePost() {
        Task {
            if let id = post.id {
                await PostService.shared.deletePost(id)
            }
        }
    }
    
    func unlikePost() {}
    
    func likePost() {}
}
